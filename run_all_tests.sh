#!/bin/bash

echo "=========================================="
echo "🧪 COMPLETE TEST SUITE FOR GO-RELOADED"
echo "=========================================="
echo ""

# Colour codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "----------------------------------------"
echo "📦 BASIC TESTS - Single Word Modifiers"
echo "----------------------------------------"
echo ""

# Test 1: (up)
echo "Test 1: (up) modifier"
echo "ready set go (up)" > test1.txt
go run . test1.txt output1.txt 2>/dev/null
echo "Input:    'ready set go (up)'"
echo "Got:      '$(cat output1.txt)'"
echo "Expected: 'ready set GO'"
echo ""

# Test 2: (low)
echo "Test 2: (low) modifier"
echo "I should stop SHOUTING (low)" > test2.txt
go run . test2.txt output2.txt 2>/dev/null
echo "Input:    'I should stop SHOUTING (low)'"
echo "Got:      '$(cat output2.txt)'"
echo "Expected: 'I should stop shouting'"
echo ""

# Test 3: (cap)
echo "Test 3: (cap) modifier"
echo "welcome to the brooklyn bridge (cap)" > test3.txt
go run . test3.txt output3.txt 2>/dev/null
echo "Input:    'welcome to the brooklyn bridge (cap)'"
echo "Got:      '$(cat output3.txt)'"
echo "Expected: 'welcome to the brooklyn Bridge'"
echo ""

# Test 4: Multiple modifiers
echo "Test 4: Multiple single modifiers"
echo "hello (up) WORLD (low) test (cap)" > test4.txt
go run . test4.txt output4.txt 2>/dev/null
echo "Input:    'hello (up) WORLD (low) test (cap)'"
echo "Got:      '$(cat output4.txt)'"
echo "Expected: 'HELLO world Test'"
echo ""

echo "----------------------------------------"
echo "📦 MULTI-WORD MODIFIER TESTS"
echo "----------------------------------------"
echo ""

# Test 5: (up, 2)
echo "Test 5: (up, 2) modifier"
echo "this is so exciting (up, 2)" > test5.txt
go run . test5.txt output5.txt 2>/dev/null
echo "Input:    'this is so exciting (up, 2)'"
echo "Got:      '$(cat output5.txt)'"
echo "Expected: 'this is SO EXCITING'"
echo ""

# Test 6: (low, 3)
echo "Test 6: (low, 3) modifier"
echo "MAKE THIS THING lowercase (low, 3)" > test6.txt
go run . test6.txt output6.txt 2>/dev/null
echo "Input:    'MAKE THIS THING lowercase (low, 3)'"
echo "Got:      '$(cat output6.txt)'"
echo "Expected: 'MAKE this thing lowercase'"
echo ""

# Test 7: (cap, 3)
echo "Test 7: (cap, 3) modifier"
echo "the empire state building (cap, 3)" > test7.txt
go run . test7.txt output7.txt 2>/dev/null
echo "Input:    'the empire state building (cap, 3)'"
echo "Got:      '$(cat output7.txt)'"
echo "Expected: 'Empire State Building'"
echo ""

# Test 8: (cap, 6)
echo "Test 8: (cap, 6) from requirements"
echo "it was the age of foolishness (cap, 6)" > test8.txt
go run . test8.txt output8.txt 2>/dev/null
echo "Input:    'it was the age of foolishness (cap, 6)'"
echo "Got:      '$(cat output8.txt)'"
echo "Expected: 'It Was The Age Of Foolishness'"
echo ""

echo "=========================================="
echo "🎯 OFFICIAL AUDIT TESTS"
echo "=========================================="
echo ""

# Audit Test 1
echo "AUDIT TEST 1: Multi-word modifiers"
echo "If I make you BREAKFAST IN BED (low, 3) just say thank you instead of: how (cap) did you get in my house (up, 2) ?" > sample.txt
go run . sample.txt result.txt 2>/dev/null
echo "Input:    'If I make you BREAKFAST IN BED (low, 3) just say thank you instead of: how (cap) did you get in my house (up, 2) ?'"
echo "Got:      '$(cat result.txt)'"
echo "Expected: 'If I make you breakfast in bed just say thank you instead of: How did you get in MY HOUSE?'"
echo ""

# Audit Test 2
echo "AUDIT TEST 2: Hexadecimal and Binary conversions"
echo "I have to pack 101 (bin) outfits. Packed 1a (hex) just to be sure" > sample.txt
go run . sample.txt result.txt 2>/dev/null
echo "Input:    'I have to pack 101 (bin) outfits. Packed 1a (hex) just to be sure'"
echo "Got:      '$(cat result.txt)'"
echo "Expected: 'I have to pack 5 outfits. Packed 26 just to be sure'"
echo ""

# Audit Test 3
echo "AUDIT TEST 3: Punctuation spacing"
echo "Don not be sad ,because sad backwards is das . And das not good" > sample.txt
go run . sample.txt result.txt 2>/dev/null
echo "Input:    'Don not be sad ,because sad backwards is das . And das not good'"
echo "Got:      '$(cat result.txt)'"
echo "Expected: 'Don not be sad, because sad backwards is das. And das not good'"
echo ""

# Audit Test 4
echo "AUDIT TEST 4: Combined features"
echo "harold wilson (cap, 2) : ' I am a optimist ,but a optimist who carries a raincoat . '" > sample.txt
go run . sample.txt result.txt 2>/dev/null
echo "Input:    'harold wilson (cap, 2) : ' I am a optimist ,but a optimist who carries a raincoat . ''"
echo "Got:      '$(cat result.txt)'"
echo "Expected: 'Harold Wilson: 'I am an optimist, but an optimist who carries a raincoat.''"
echo ""

echo "=========================================="
echo "📋 PROJECT REQUIREMENT SAMPLES"
echo "=========================================="
echo ""

# Sample 1
echo "SAMPLE 1: Tale of Two Cities"
echo "it (cap) was the best of times, it was the worst of times (up) , it was the age of wisdom, it was the age of foolishness (cap, 6) , it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of darkness, it was the spring of hope, IT WAS THE (low, 3) winter of despair." > sample.txt
go run . sample.txt result.txt 2>/dev/null
echo "Input:    'it (cap) was the best of times, it was the worst of times (up) , it was the age of wisdom, it was the age of foolishness (cap, 6) , it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of darkness, it was the spring of hope, IT WAS THE (low, 3) winter of despair.'"
echo "Got:      '$(cat result.txt)'"
echo "Expected: 'It was the best of times, it was the worst of TIMES, it was the age of wisdom, It Was The Age Of Foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of darkness, it was the spring of hope, it was the winter of despair.'"
echo ""

# Sample 2
echo "SAMPLE 2: Hex and Binary maths"
echo "Simply add 42 (hex) and 10 (bin) and you will see the result is 68." > sample.txt
go run . sample.txt result.txt 2>/dev/null
echo "Input:    'Simply add 42 (hex) and 10 (bin) and you will see the result is 68.'"
echo "Got:      '$(cat result.txt)'"
echo "Expected: 'Simply add 66 and 2 and you will see the result is 68.'"
echo ""

# Sample 3
echo "SAMPLE 3: Article (a/an) correction"
echo "There is no greater agony than bearing a untold story inside you." > sample.txt
go run . sample.txt result.txt 2>/dev/null
echo "Input:    'There is no greater agony than bearing a untold story inside you.'"
echo "Got:      '$(cat result.txt)'"
echo "Expected: 'There is no greater agony than bearing an untold story inside you.'"
echo ""

# Sample 4
echo "SAMPLE 4: Punctuation groups"
echo "Punctuation tests are ... kinda boring ,what do you think ?" > sample.txt
go run . sample.txt result.txt 2>/dev/null
echo "Input:    'Punctuation tests are ... kinda boring ,what do you think ?'"
echo "Got:      '$(cat result.txt)'"
echo "Expected: 'Punctuation tests are... kinda boring, what do you think?'"
echo ""

echo "=========================================="
echo "🧹 Tidy Up"
echo "=========================================="
echo ""

read -p "Do you want to delete all test files? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -f test*.txt output*.txt sample.txt result.txt
    echo "✅ Test files tidied up!"
else
    echo "ℹ️  Test files kept for inspection"
fi

echo ""
echo "=========================================="
echo "✅ ALL TESTS COMPLETE!"
echo "=========================================="