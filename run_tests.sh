#!/bin/bash

echo "Running tests..."

# Test 1: (up)
echo "ready set go (up)" > test1.txt
go run . test1.txt output1.txt
echo "Test 1 - Expected: 'ready set GO'"
echo "Test 1 - Got:      '$(cat output1.txt)'"
echo ""

# Test 2: (low)
echo "I should stop SHOUTING (low)" > test2.txt
go run . test2.txt output2.txt
echo "Test 2 - Expected: 'I should stop shouting'"
echo "Test 2 - Got:      '$(cat output2.txt)'"
echo ""

# Test 3: (cap)
echo "welcome to the brooklyn bridge (cap)" > test3.txt
go run . test3.txt output3.txt
echo "Test 3 - Expected: 'welcome to the brooklyn Bridge'"
echo "Test 3 - Got:      '$(cat output3.txt)'"
echo ""

# Test 4: Multiple
echo "hello (up) WORLD (low) test (cap)" > test4.txt
go run . test4.txt output4.txt
echo "Test 4 - Expected: 'HELLO world Test'"
echo "Test 4 - Got:      '$(cat output4.txt)'"

echo "All tests complete!"