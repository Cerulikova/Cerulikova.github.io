def distance1(planA, planB):
    listA = splitPlan(planA)
    listB = splitPlan(planB)
    lenA = len(listA)
    lenB = len(listB)
    matrix = createMatrix(lenA, lenB)

    for i in range(1,lenA+1):
        matrix[i][0] = i

    for i in range(1,lenB+1):
        matrix[0][i] = i
    solveMatrix(matrix, lenA, lenB, listA, listB)
    #prettyPrint(matrix)
    return matrix[lenA][lenB]

def splitPlan(plan):
    return plan.replace("(","").replace(")", "").split()

def createMatrix(m, n):
    matrix = []
    for i in range(m+1):
        matrix.append([0]*(n+1))
    return matrix

def solveMatrix(matrix, m, n, listA, listB):
    for j in range(1, n+1):
        for i in range(1, m+1):
            substitutionCost = 0
            if listA[i-1] != listB[j-1]:
                substitutionCost = 1
            matrix[i][j] = min(matrix[i-1][j] + 1,
                               matrix[i][j-1] + 1,
                               matrix[i-1][j-1] + substitutionCost)

####################################################

def distance2(planA, planB):
    actA = splitPlanActions(planA)
    actB = splitPlanActions(planB)
    lenA = len(actA)
    lenB = len(actB)
    matrix = createMatrix(lenA, lenB)

    for i in range(1,lenA+1):
        matrix[i][0] = i

    for i in range(1,lenB+1):
        matrix[0][i] = i

    solveMatrix2(matrix, lenA, lenB, actA, actB)
    prettyPrint(matrix)
    return matrix[lenA][lenB]

def splitPlanActions(plan):
    if plan[-1] == ")":
        plan = plan[:-1]
    tmp = plan.replace("(", "").split(")")
    res = []
    for action in tmp:
        res.append(action.split())
    return res

def solveMatrix2(matrix, m, n, actA, actB):
    for j in range(1, n+1):
        for i in range(1, m+1):
            substitutionCost = countSubstitutionCost(actA[i-1], actB[j-1])
            matrix[i][j] = min(matrix[i-1][j] + 1,
                               matrix[i][j-1] + 1,
                               matrix[i-1][j-1] + substitutionCost)

def countSubstitutionCost(actionA, actionB):
    if actionA[0] != actionB[0]:
        return 1
    parameterCost = 1/(len(actionA) - 1)
    totalCost = 0
    for i in range(1, len(actionA)):
        if actionA[i] != actionB[i]:
            totalCost += parameterCost
    return totalCost
    

def prettyPrint(matrix):
    s = [[str(e) for e in row] for row in matrix]
    lens = [max(map(len, col)) for col in zip(*s)]
    fmt = '\t'.join('{{:{}}}'.format(x) for x in lens)
    table = [fmt.format(*row) for row in s]
    print( '\n'.join(table))

def removeNumbers(plan):
    planList = plan.split('\n')
    newPlanList = []
    for action in planList:
        a = action.strip()
        newAction = ""
        numberOfNs = 0
        for i in range(-2, -(len(a)+1),-1):
            if numberOfNs >= 2:
                newAction = action[i] + newAction
            if action[i] == 'n':
                numberOfNs += 1
        newPlanList.append(newAction.strip() + ")")
    return '\n\t'.join(newPlanList)

testA = "k i t t e n"
testB = "s i t t i n g"

planA = '''(go hopper mill village)
	(go hopper village shop)
	(steal hopper shopkeeper old_book shop)
	(go hopper shop village)
	(go hopper village mill)
	(buy mage hopper gold_coin old_book mill)'''

planB = '''(go hopper mill village)
	(go hopper village meadow)
	(collect hopper black_lily meadow)
	(go hopper meadow village)
	(go hopper village shop)
	(buy shopkeeper hopper old_book black_lily shop)
	(go hopper shop village)
	(go hopper village mill)
	(buy mage hopper gold_coin old_book mill)'''

planC = removeNumbers(
     '''(go hopper village shop o_go n0 n1)
	(exchange shopkeeper hopper metal gold_coin shop o_exchange n1 n2)
	(go hopper shop village o_go n2 n3)
	(give hopper hunter metal village o_give n3 n4)
	(fix_item hunter sword metal o_fix_i n4 n5)
	(give hunter hopper sword village o_give n5 n6)
	(go hopper village meadow o_go n6 n7)
	(attack_character hopper warewolf meadow o_attack_ch n7 n8)
	(kill hopper warewolf meadow o_kill n8 n9)''')

planD = removeNumbers(
     '''(go hopper village shop o_go n0 n1)
	(exchange shopkeeper hopper metal gold_coin shop o_exchange n1 n2)
	(go hopper shop village o_go n2 n3)
	(give hopper hunter metal village o_give n3 n4)
	(fix_item hunter sword metal o_fix_i n4 n5)
	(give hunter hopper sword village o_give n5 n6)
	(go hopper village meadow o_go n6 n7)
	(attack_character hopper warewolf meadow o_attack_ch n7 n8)
	(attack_character hopper warewolf meadow o_attack_ch n8 n9)
	(kill hopper warewolf meadow o_kill n9 n10)''')
