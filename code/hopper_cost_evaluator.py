import subprocess
import random

class HopperCostEvaluator:
    #domain and problem must be absolute path

    def __init__(self):
        self.acceptedDomain = "hopper_cost_world"
        self.currentProblem = r"D:\A_Diplomovka_code\planner\current.pddl"
        self.resultFile = r"foundSolutions.txt"
        self._actionCostFunctionID = 1
        self._fastDownward = r"D:\A_Diplomovka_code\planner\fd.bat"
        self._functionsCosts = {}
        self._solutions = {}
        self._domain = None
        self._problem = None

    def run(self, domain, problem, repeat):
        self.setDomain(domain)
        self.setProblem(problem)
        if self._domain == None or self._problem == None:
            return
        self._solutions.clear()
        self.setFunctionsFromDomain()
        for i in range(repeat):
            self.createCurrentProblem()
            self.runPlanner()
            self.processSolution()
        self.writeSolutionsToFile()
        print(str(len(self._solutions)) + " solutions found")

    def setActionCostFunction(self, functionID):
        if functionID < 1 or functionID > 3:
            print("Incorrect function ID")
            return
        self._actionCostFunctionID = functionID

    def setDomain(self, domain):
        domainFile = open(domain, 'r')
        for line in domainFile:
            line = line.strip()
            if len(line) == 0 or line[0] == ';':
                continue
            if line == "(define (domain " + self.acceptedDomain + ")":
                self._domain = domain
                print("Domain set")
                break
            print("Incorrect domain file. Can accept only: " + self.acceptedDomain)
            break
        domainFile.close()

    def setProblem(self, problem):
        problemFile = open(problem, 'r')
        numberOfFullLines = 0
        for line in problemFile:
            line = line.strip()
            if len(line) == 0 or line[0] == ';':
                continue
            defineProblem = "(define (problem "
            if line[:len(defineProblem)] == defineProblem:
                numberOfFullLines +=1
                continue
            if line == "(:domain " + self.acceptedDomain + ")":
                if numberOfFullLines == 1:
                    self._problem = problem
                    self._functionsCosts.clear()
                    print("Problem set")
                    break
            print("Incorrect problem file. Expected : (:domain "
                  + self.acceptedDomain + "). Got: " + line)
            break
        problemFile.close()          

    def setFunctionsFromDomain(self):
        if self._domain == None:
            print("There is no domain file set.")
            retur
        domainFile = open(self._domain, 'r')
        readFunctions = False
        
        for line in domainFile:
            line = line.strip()
            if len(line) == 0 or line[0] == ';':
                continue
            if line == "(:functions" and readFunctions == False:
                readFunctions = True
                continue
            if readFunctions == True:
                functionList = line.split(" - ")
                if len(functionList) == 2 and functionList[1] == "number":
                    self._functionsCosts[functionList[0]] = 0
                else:
                    break
        domainFile.close()
        print("Functions set.")
        return

    def createCurrentProblem(self):
        problemFile = open(self._problem, 'r')
        current = open(self.currentProblem, 'w')
        for line in problemFile:
            if self.isFunctionValue(line):
                continue
            current.write(line)
            if line.strip() == "(:init":
                for func, cost in self._functionsCosts.items():
                    current.write("\t\t(= " + func +" " + str(cost) + ")\n")
            
        return

    def isFunctionValue(self, line):
        return line.strip()[:2] == "(="

    def runPlanner(self):
        wslDomain = self.windowsToWsl(self._domain)
        wslCurrent = self.windowsToWsl(self.currentProblem)
        res = subprocess.run(["cmd", "/c", self._fastDownward, wslDomain, wslCurrent])
        #print(res.stdout)

    def processSolution(self):
        solutionFile = open("sas_plan", "r")
        solution = ""
        actions = []
        for line in solutionFile:
            if line[0] == ';':
                continue
            solution += line
            actions.append(line.split()[0].replace("(", ""))
        solutionFile.close()
        self.addSolution(solution)
        match self._actionCostFunctionID:
            case 1:
                self.updateFunctionsCosts1(actions)
            case 2:
                self.updateFunctionsCosts2(actions)
            case 3:
                self.updateFunctionsCosts3(actions)

    def addSolution(self, solution):
        if solution in self._solutions:
            self._solutions[solution] += 1
        else:
            self._solutions[solution] = 1
    
    def updateFunctionsCosts1(self, actions):
        #INCREASE COST BY ONE FOR THE FIRST APPEARANCE IN THE SOLUTION
        usedActions = set(actions)
        for action in usedActions:
            functionName = "(" + action + "-cost)"
            if functionName in self._functionsCosts:
                self._functionsCosts[functionName] += 1

    def updateFunctionsCosts2(self, actions):
        #INCREASE COST BY ONE FOR EACH APPEARANCE IN THE SOLUTION
        for action in actions:
            functionName = "(" + action + "-cost)"
            if functionName in self._functionsCosts:
                self._functionsCosts[functionName] += 1

    def updateFunctionsCosts3(self, actions):
        #INCREASE COST OF ACTIONS IN SOLUTION BY RANDOM VALUE (0-5)
        usedActions = set(actions)
        for action in usedActions:
            functionName = "(" + action + "-cost)"
            if functionName in self._functionsCosts:
                self._functionsCosts[functionName] += random.randrange(0,5)

    def writeSolutionsToFile(self):
        result = open(self.resultFile, "w")
        i = 1
        for sol, n in self._solutions.items():
            result.write(str(i) + ". solution:\n")
            result.write(sol)
            result.write("Solution was repeated " + str(n) + " times.\n\n")
            i += 1
        result.close()

    def windowsToWsl(self, path):
        p = path.replace("\\", "/")
        disk = p[0].lower()
        return "/mnt/"+ disk + p[2:]
        
