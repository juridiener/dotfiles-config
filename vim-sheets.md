https://neovim.io/doc/user/quickref.html#_-quick-reference-guide

# Vim Sheets

# Command Line tools

## In Terminal:

To edit all files in the current folder, use: - vim _
To edit all files in tabs, use: - vim -p _
To edit all files in horizontally split windows, use: - vim -o \*

Open all files include subdirectories - vim `find . -type f`

## noraml mode

<C-a> = increment number
<C-x> = decrement number

### Copy | Cut | paste

i = insert before char
I = insert beginning of the line
a = insert after char
o = insert after new line
A = insert mode end of the line
O = start of line
ea - insert (append) at the end of the word
w = forward beginning of word
3w = forward 3 words
W = forward none whitespace
e = forward by end of the word
M = jump middle of screen
< = indent text
y = copy char
yy = copy line
yaw | byw = copy word
daw = delete word
P - put (paste) before cursor
"0p = paste from 0 register:reg
s = delete cahr & insert mode
S = delete line & insert mode
D = delete at cursor to end of line
x = delete char
X = delete hinteren char
cc = delete line & insert mode
za = folding
b = backword beginning of word
ge = jump backwards to the end of a word
G = go to end of file
gg = go to the first line of the document
gt = tab next
H = go to begining of file
J = delete Spaces
% = Jump to corresponding item, e.g. from an open brace to its matching closing brace
| = Jump to the 1st column of the current line
42| = Jump to the 42nd column of the current line
g; = Jump to the place of last edit. (back) : in current file
g, = Jump to the place of new edit (forth) : in current file
== = Select line and press (==) indent the lines

" = Return to the line where the cursor was before the latest jump.
`` = Return to the cursor position before the latest jump (undo the jump)
#(hash) = go to the next word in the cursor
~ = toggle upper and lowercase at cursor position or selected text

## SEARCH

/and the word to search
if you want delete the word under the cursor with the search pattern type cgn | dgn

## SEARCH AND REPLACE

% = (means in all lines)
g = all words in a line
e = if no match found, no error thrown if e is set Example: (:%s/\<GetResp\>/GetAnswer/ge)

This replace four with 4, in all words like thirtyfour and fourteen
:%s/four/4/g
For exact word matching \<four\> (\< means match start of the word || \> means end of the word)
:%s/\<four\>/4/gc

Search in a specific directory
** = recursive
:vim /searchText/ /directory/**
:copen = open the quickfix list

### Replace the text in all files in the quickfix list

:cdo s/searchText/replaceText/ | update

// https://www.youtube.com/watch?v=6Pu0V0tdT8w&list=PLfDYHelvG44BNGMqjVizsKFpJRsrmqfsJ&index=2

### Atoms can be counted with {n}

'.' => Matches any single character
'.\*' => Matches zero or more of any character
'.+' => Matches one or more of any character
'()' => Matches group
'\w' => Matches any word
'\d' => Matches any digit
'\s' => Matches any whitespace
'\v' => Magic mode
'\r' => Matches a newline
'\zs' => use patterns to find a position but only include what comes after match
'\ze' => use patterns to find a position but only include what comes before match
'/\%V' => match inside a visual selection

'&' => the word which was searched for, like placeholder

Example 1: Onxe replace to Once

- :%s/^On\zs\w/c
- %s => whole file
- ^ => beginning of the line
- zs => every after On
- w => single character
- /c => replace that single character with 'c'

Example 2: Once upon a time, in a land far, far way replace to Once upon a very long time, ....
%s/\vOnce\zs(.\*)\zetime/& very long

---> look at the video at 21:00 for more information
:g stand for global, it executes a command on all lines that match the search pattern
:g/^$/d => delete empty lines
:g/search_string/norm gU$ => Convert matching lines to uppercase
:v/old/new/g => negate the search pattern

### Jump through quickfix list

"open bracket [q" = prev
"close bracket ]q" = next

## Scrolling

Ctrl + e - move screen down one line (without moving cursor)
Ctrl + y - move screen up one line (without moving cursor)
Ctrl + b - move back one full screen
Ctrl + f - move forward one full screen
Ctrl + d - move forward 1/2 a screen
Ctrl + u - move back 1/2 a screen

## Splits & Window

"Max out the height of the current split
ctrl + w \_
"Max out the width of the current split
ctrl + w |
"Normalize all split sizes, which is very handy when resizing terminal
ctrl + w =
"Swap top/bottom or left/right split
Ctrl+W R
"Break out current window into a new tabview
Ctrl+W T
"Close every window in the current tabview but the current one

To close all windows but the current one use:
CTRL+w, o = That is, first CTRL+w and then o Ctrl+W o

:sp filename Open filename in horizontal split
:vsp filename Open filename in vertical split
Ctrl-w h Ctrl-w √¢¬Ü¬ê Shift focus to split on left of current
Ctrl-w l Ctrl-w √¢¬Ü¬í Shift focus to split on right of current
Ctrl-w j Ctrl-w √¢¬Ü¬ì Shift focus to split below the current
Ctrl-w k Ctrl-w √¢¬Ü¬ë Shift focus to split above the current
Ctrl-w n+ Increase size of current split by n lines
Ctrl-w n- Decrease size of current split by n lines

## change split orientation

ctrl-w H √ê Change horizontal splits to vertical
ctrl-w K √ê Change vertical splits to horizontal

## Visual Mode

u = lowercase
U = uppercase
= = Select line and press (=) indent the lines

## Additional Information

dw - at the cursor
diw - delete whole word
dib | di( - delete all inside ()
yy | Y = copy line including the newline character at the end
y$ - copy line without the new line character at the end
yiw √¢¬Ä¬ì yank the current word (excluding surrounding whitespace)
yaw √¢¬Ä¬ì yank the current word (including leading or trailing whitespace)
ytx √¢¬Ä¬ì yank from the current cursor position up to and before the character (til x)
yfx √¢¬Ä¬ì yank from the current cursor position up to and including the character (find x)
vit = HTML select everything inside this html-tag under the cursor
vat = HTML select everything under the html-tag include itself

# Important links

## tabs = https://www.linux.com/training-tutorials/vim-tips-using-tabs/

# Cool Stuff

### Do math multiplication for example on a csv-file.

- In normal mode press on the number ciw (this cut the number in register ")
- Then in insert mode press <C-r>= (this put you in command line mode)
- Now press <C-r>" (This paste the number from register)
- Now you can do any Math you want
- this works to with a macro start first with macro and then the steps with ciw

### Sort csv-file by column in asc

- Select all the lines to sort
- Then press :
- Then press %!sort -t "," -k3
- "," = seperator
- -k3 = column 3

### Put Messages in a buffe or clipboard

Buffer:
:put =execute('messages')
Clipoard:
:let @+ = execute('messages')

# Comman Befehle

get filetype name for files and plugins
:echo &ft
example open telescope and then type :echo &ft

## Macros

stop macro = <C-c>

q = start recording, m = register can any char, q = stop recording
Empty a register for macro run qmq and then the macro with qm
run macro : @m or 20@m

run macro in command mode:
2 + start line, 3 = end line, normal or norm = normal-mode

```
:2,3 normal @m
```

Run macro from current cursor position:
. = current corsor position, $ = end of buffer

```
:.,$normal @m
```

Macro only execute the macro in the selection with a pattern.

```vim
:[range]g/pattern/cmd
```

1. First type the macro for one line
   a. qmq = empty the register m
   b. qm = start recording
   c. o<p></p>q = type your macro
   d. select your text
   e. :g/row/ norm @m = execute macro on selection

---

If the Macro adds new lines or deletes line, then it would not work soemthing like this @4q
To repeat the macro number of times you have to select the content and going to command mode.

Example: Select lines gives you following after pressing : '<,'>

- '<,'>g/^/norm! @q
- '<,'> => Are the selected lines
- g => global
- ^ => every line in the selection
- norm! => execute only my macro
- @q => macro in register q

http://vimdoc.sourceforge.net/htmldoc/usr_30.html

This adds one indent to the current block of lines, inside {}. The { and }
lines themselves are left unmodified. ">a{" includes them. In this example
the cursor is on "printf":

    original text		after ">i{"		after ">a{"

    if (flag)		if (flag)		if (flag)
    {			{			    {
    printf("yes");		    printf("yes");	    printf("yes");
    flag = 0;		    flag = 0;		    flag = 0;
    }			}			    }

---

## Delete all lines with following Text

:g/puts/norm! dd

# Additional Information

For example, you could select the text hello then type "ay to copy "hello" to the a register.
Then you could select the text world and type "by to copy "world" to the b register.
After moving the cursor to another location, the text could be pasted: type "ap to paste "hello" or "bp to paste "world".
These commands paste the text after the cursor. Alternatively, type "aP or "bP to paste before the cursor.
