# Permutations with Repeats

The number of permutations of a list that includes repeats is (factorial of list length) / (product of factorials of each items repeat frequency)
for the list 0 0 1 2 the permutations in order are
```
    0 0 1 2
	0 0 2 1    
	0 1 0 2   
	0 1 2 0
	0 2 0 1    
	0 2 1 0    
	1 0 0 2    
	1 0 2 0    
	1 2 0 0    
	2 0 0 1    
	2 0 1 0    
	2 1 0 0
```
    
## Challenges
**1. Calculate permutation number of list that may include repeats**

The permutation number is similar to Monday and Wednesday's challenge. But only wednesday's approach of calculating it without generating the full list will work (fast) for the longer inputs. The input varies from previous ones in that you are provided a list rather than a number to account for possible repeats. If there are no repeats, then the answer is the same as the part 2 (wednesday) challenge.

**```input:```**
```
	5 4 3 2 1 0
	2 1 0 0
	5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0
	8 8 8 8 8 8 8 8 8 7 7 7 6 5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0 6 7 8
```
**```output: (0 based indexes)```**
```
	719
	11
	10577286119
	3269605362042919527837624
```
	
**2. retrieve list from permutation number and sorted list**

**```input is in format: permutation_number, sorted list to permute
input:```**
```
    719, 0 1 2 3 4 5  
	11, 0 0 1 2
	10577286119, 0 0 0 0 0 1 1 1 1 1 2 2 2 3 4 5 5 5
	3269605362042919527837624, 0 0 0 0 0 1 1 1 1 1 2 2 2 3 4 5 5 5 6 6 7 7 7 7 8 8 8 8 8 8 8 8 8 8
```
**```output:```**
```
	5 4 3 2 1 0
	2 1 0 0
	5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0
	8 8 8 8 8 8 8 8 8 7 7 7 6 5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0 6 7 8
```

**3. bonus

use the above function and wednesday's combination number (optional) to compress/encode a list into a fixed set of numbers (with enough information to decode it)

**```input:```**
```
hello, heely owler world!
```

You might wish to convert to ascii, then calculate the combination number for the unique ascii codes, then calculate the permutation number with each letter replaced by contiguous indexes.

# Results

```
5 4 3 2 1 0
719
10000 loops, 2.2415994404582306e-05 secs per loop.

2 1 0 0
11
10000 loops, 2.8540465002879502e-05 secs per loop.

5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0
10577286119
10000 loops, 2.438627469819039e-05 secs per loop.

8 8 8 8 8 8 8 8 8 7 7 7 6 5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0 6 7 8
3269605362042919527837624
10000 loops, 5.725970210041851e-05 secs per loop.

['719', '0 1 2 3 4 5']
[5 4 3 2 1 0]
10000 loops, 1.9432027102448046e-05 secs per loop.

['11', '0 0 1 2']
[2 1 0 0]
10000 loops, 2.277089459821582e-05 secs per loop.

['10577286119', '0 0 0 0 0 1 1 1 1 1 2 2 2 3 4 5 5 5']
[5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0]
10000 loops, 2.5534270401112735e-05 secs per loop.

['3269605362042919527837624', '0 0 0 0 0 1 1 1 1 1 2 2 2 3 4 5 5 5 6 6 7 7 7 7 8 8 8 8 8 8 8 8 8 8']
[8 8 8 8 8 8 8 8 8 7 7 7 6 5 0 1 2 5 0 1 2 0 0 1 1 5 4 3 2 1 0 6 7 8]
10000 loops, 5.698170639807358e-05 secs per loop.

# ASCII Codes for "hello, heely owler world!"
104 101 108 108 111 44 32 104 101 101 108 121 32 111 119 108 101 114 32 119 111 114 108 100 33
7993781807462119055
10000 loops, 3.8503253099042925e-05 secs per loop.
```