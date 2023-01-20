def merge (a, left, midpt, right):
    sizeleft = midpt - left + 1
    sizeRight = right - midpt

    vLeft = [None] * sizeleft
    vRight = [None] * sizeRight

    for i in range(sizeleft):
        vLeft[i] = a[left + i]

    for i in range(sizeRight):
        vRight[i] = a[midpt + 1 + i]

    indexLeft = 0
    indexRight = 0
    indexMerged = left
    merged = []

    while indexLeft < sizeleft and indexRight < sizeRight:
        if vLeft[indexLeft] <= vRight[indexRight]:
            merged.append(vLeft[indexLeft])
            indexLeft += 1
        else:
            merged.append(vRight[indexRight])
            indexRight += 1
        indexMerged += 1
    
    while indexLeft < sizeleft:
        merged.append(vLeft[indexLeft])
        indexLeft += 1
        indexMerged += 1

    while indexRight < sizeRight:
        merged.append(vRight[indexRight])
        indexRight += 1
        indexMerged += 1
    
    for i in range(len(merged)):
        a[left + i] = merged[i]
        yield a

def mergesort (a, left, right):
    if left >= right:
        return
    
    midpt = left + ((right - left + 1) // 2) - 1

    yield from mergesort(a, left, midpt)
    yield from mergesort(a, midpt + 1, right)
    yield from merge(a, left, midpt, right)