#!/bin/bash

# Change to project root directory (one level up from scripts/)
cd "$(dirname "$0")/.." || exit

echo "=========================================="
echo "🧪 COMPLETE TEST SUITE FOR GO-RELOADED"
echo "=========================================="
echo ""

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "----------------------------------------"
echo "📦 BASIC TESTS - Single Word Modifiers"
echo "----------------------------------------"
echo ""

echo "Test 1: (up) modifier"
echo "ready set go (up)" > testdata/test1.txt
go run . testdata/test1.txt testdata/output1.txt 2>/dev/null
echo "Input:    'ready set go (up)'"
echo "Got:      '$(cat testdata/output1.txt)'"
echo "Expected: 'ready set GO'"
echo ""

echo "Test 2: (low) modifier"
echo "I should stop SHOUTING (low)" > testdata/test2.txt
go run . testdata/test2.txt testdata/output2.txt 2>/dev/null
echo "Input:    'I should stop SHOUTING (low)'"
echo "Got:      '$(cat testdata/output2.txt)'"
echo "Expected: 'I should stop shouting'"
echo ""

echo "Test 3: (cap) modifier"
echo "welcome to the brooklyn bridge (cap)" > testdata/test3.txt
go run . testdata/test3.txt testdata/output3.txt 2>/dev/null
echo "Input:    'welcome to the brooklyn bridge (cap)'"
echo "Got:      '$(cat testdata/output3.txt)'"
echo "Expected: 'welcome to the brooklyn Bridge'"
echo ""

echo "Test 4: Multiple single modifiers"
echo "hello (up) WORLD (low) test (cap)" > testdata/test4.txt
go run . testdata/test4.txt testdata/output4.txt 2>/dev/null
echo "Input:    'hello (up) WORLD (low) test (cap)'"
echo "Got:      '$(cat testdata/output4.txt)'"
echo "Expected: 'HELLO world Test'"
echo ""

echo "----------------------------------------"
echo "📦 MULTI-WORD MODIFIER TESTS"
echo "----------------------------------------"
echo ""

echo "Test 5: (up, 2) modifier"
echo "this is so exciting (up, 2)" > testdata/test5.txt
go run . testdata/test5.txt testdata/output5.txt 2>/dev/null
echo "Input:    'this is so exciting (up, 2)'"
echo "Got:      '$(cat testdata/output5.txt)'"
echo "Expected: 'this is SO EXCITING'"
echo ""

echo "Test 6: (low, 3) modifier"
echo "MAKE THIS THING lowercase (low, 3)" > testdata/test6.txt
go run . testdata/test6.txt testdata/output6.txt 2>/dev/null
echo "Input:    'MAKE THIS THING lowercase (low, 3)'"
echo "Got:      '$(cat testdata/output6.txt)'"
echo "Expected: 'MAKE this thing lowercase'"
echo ""

echo "Test 7: (cap, 3) modifier"
echo "the empire state building (cap, 3)" > testdata/test7.txt
go run . testdata/test7.txt testdata/output7.txt 2>/dev/null
echo "Input:    'the empire state building (cap, 3)'"
echo "Got:      '$(cat testdata/output7.txt)'"
echo "Expected: 'the Empire State Building'"
echo ""

echo "Test 8: (cap, 6) from requirements"
echo "it was the age of foolishness (cap, 6)" > testdata/test8.txt
go run . testdata/test8.txt testdata/output8.txt 2>/dev/null
echo "Input:    'it was the age of foolishness (cap, 6)'"
echo "Got:      '$(cat testdata/output8.txt)'"
echo "Expected: 'It Was The Age Of Foolishness'"
echo ""

echo "=========================================="
echo "🎯 OFFICIAL AUDIT TESTS"
echo "=========================================="
echo ""

echo "AUDIT TEST 1: Multi-word modifiers"
echo "If I make you BREAKFAST IN BED (low, 3) just say thank you instead of: how (cap) did you get in my house (up, 2) ?" > testdata/sample.txt
go run . testdata/sample.txt testdata/result.txt 2>/dev/null
echo "Input:    'If I make you BREAKFAST IN BED (low, 3) just say thank you instead of: how (cap) did you get in my house (up, 2) ?'"
echo "Got:      '$(cat testdata/result.txt)'"
echo "Expected: 'If I make you breakfast in bed just say thank you instead of: How did you get in MY HOUSE?'"
echo ""

echo "AUDIT TEST 2: Hexadecimal and Binary conversions"
echo "I have to pack 101 (bin) outfits. Packed 1a (hex) just to be sure" > testdata/sample.txt
go run . testdata/sample.txt testdata/result.txt 2>/dev/null
echo "Input:    'I have to pack 101 (bin) outfits. Packed 1a (hex) just to be sure'"
echo "Got:      '$(cat testdata/result.txt)'"
echo "Expected: 'I have to pack 5 outfits. Packed 26 just to be sure'"
echo ""

echo "AUDIT TEST 3: Punctuation spacing"
echo "Don not be sad ,because sad backwards is das . And das not good" > testdata/sample.txt
go run . testdata/sample.txt testdata/result.txt 2>/dev/null
echo "Input:    'Don not be sad ,because sad backwards is das . And das not good'"
echo "Got:      '$(cat testdata/result.txt)'"
echo "Expected: 'Don not be sad, because sad backwards is das. And das not good'"
echo ""

echo "AUDIT TEST 4: Combined features"
echo "harold wilson (cap, 2) : ' I am a optimist ,but a optimist who carries a raincoat . '" > testdata/sample.txt
go run . testdata/sample.txt testdata/result.txt 2>/dev/null
echo "Input:    'harold wilson (cap, 2) : ' I am a optimist ,but a optimist who carries a raincoat . ''"
echo "Got:      '$(cat testdata/result.txt)'"
echo "Expected: 'Harold Wilson: 'I am an optimist, but an optimist who carries a raincoat.''"
echo ""

echo "=========================================="
echo "📋 PROJECT REQUIREMENT SAMPLES"
echo "=========================================="
echo ""

echo "SAMPLE 1: Tale of Two Cities"
echo "it (cap) was the best of times, it was the worst of times (up) , it was the age of wisdom, it was the age of foolishness (cap, 6) , it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of darkness, it was the spring of hope, IT WAS THE (low, 3) winter of despair." > testdata/sample.txt
go run . testdata/sample.txt testdata/result.txt 2>/dev/null
echo "Input:    'it (cap) was the best of times, it was the worst of times (up) , it was the age of wisdom, it was the age of foolishness (cap, 6) , it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of darkness, it was the spring of hope, IT WAS THE (low, 3) winter of despair.'"
echo "Got:      '$(cat testdata/result.txt)'"
echo "Expected: 'It was the best of times, it was the worst of TIMES, it was the age of wisdom, It Was The Age Of Foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of darkness, it was the spring of hope, it was the winter of despair.'"
echo ""

echo "SAMPLE 2: Hex and Binary maths"
echo "Simply add 42 (hex) and 10 (bin) and you will see the result is 68." > testdata/sample.txt
go run . testdata/sample.txt testdata/result.txt 2>/dev/null
echo "Input:    'Simply add 42 (hex) and 10 (bin) and you will see the result is 68.'"
echo "Got:      '$(cat testdata/result.txt)'"
echo "Expected: 'Simply add 66 and 2 and you will see the result is 68.'"
echo ""

echo "SAMPLE 3: Article (a/an) correction"
echo "There is no greater agony than bearing a untold story inside you." > testdata/sample.txt
go run . testdata/sample.txt testdata/result.txt 2>/dev/null
echo "Input:    'There is no greater agony than bearing a untold story inside you.'"
echo "Got:      '$(cat testdata/result.txt)'"
echo "Expected: 'There is no greater agony than bearing an untold story inside you.'"
echo ""

echo "SAMPLE 4: Punctuation groups"
echo "Punctuation tests are ... kinda boring ,what do you think ?" > testdata/sample.txt
go run . testdata/sample.txt testdata/result.txt 2>/dev/null
echo "Input:    'Punctuation tests are ... kinda boring ,what do you think ?'"
echo "Got:      '$(cat testdata/result.txt)'"
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
    rm -f testdata/test*.txt testdata/output*.txt testdata/sample.txt testdata/result.txt
    echo "✅ Test files tidied up!"
else
    echo "ℹ️  Test files kept for inspection"
fi

echo ""
echo "=========================================="
echo "✅ ALL TESTS COMPLETE!"
echo "=========================================="