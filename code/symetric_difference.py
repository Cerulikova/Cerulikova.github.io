def symetricDifference(planA, planB):
    actionsA = makeSetOfActions(planA)
    actionsB = makeSetOfActions(planB)
    return getSymetricDifference(actionsA, actionsB)

def normalizedSymetricDifference(planA, planB):
    actionsA = makeSetOfActions(planA)
    actionsB = makeSetOfActions(planB)

    diff = getSymetricDifference(actionsA, actionsB)
    union = actionsA.union(actionsB)

    return (len(diff)/len(union))*100
    
def makeSetOfActions(plan):
    plan = plan.strip()
    return set(map(str.strip, plan.split("\n")))

def getSymetricDifference(actionsA, actionsB):
    return (actionsA.difference(actionsB)).union(actionsB.difference(actionsA))

def readPlans(plansFile):
    plans = []
    file = open(plansFile, "r")
    plan = ""
    for line in file:
        line = line.strip()
        if line == "":
            plans.append(plan)
            plan = ""
            continue
        if line[0] != "(":
            continue
        plan += line + "\n"
    file.close()
    return plans

def normalizedSymetricDifferenceOfPlans(plansFile):
    plans = readPlans(plansFile)
    numOfPlans = len(plans)
    result = {}
    for i in range(numOfPlans):
        for j in range(i+1, numOfPlans):
            key = f"{i+1}., {j+1}."
            result[key] = normalizedSymetricDifference(plans[i], plans[j])
    avg = sum(result.values())/ len(result)
    result["avg"] = avg
    return result

def symetricDifferenceOfPlans(plansFile):
    plans = readPlans(plansFile)
    numOfPlans = len(plans)
    result = {}
    for i in range(numOfPlans):
        for j in range(i+1, numOfPlans):
            key = f"{i+1}., {j+1}."
            result[key] = symetricDifference(plans[i], plans[j])
    return result
    
