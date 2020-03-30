#cs
Memoization for different functions, examples given:

   - fibonacci
   - faculty
   - collatz

   Useful only for fib, faculty is easily calculabe (even for bigger input) and collatz decreases rapidly (little speedup)
#ce

$oDictionary = ObjCreate("Scripting.Dictionary")


Func memo($func, $val)	; Memo driver func
   If $oDictionary.Exists(FuncName($func)) Then
	  If $oDictionary.Item(FuncName($func)).Exists($val) Then
		 Return $oDictionary.Item(FuncName($func)).Item($val)
	  EndIf
   Else
	  $oDictionary.Add(FuncName($func), ObjCreate("Scripting.Dictionary"))
   EndIf

   $val_ = $func($val)
   $oDictionary.Item(FuncName($func)).Add($val, $val_)

   Return $val_
EndFunc




Func fib($number)	; Memoizationed function
   if $number == 0 or $number == 1 Then
	  Return 1
   EndIf

   Return memo(fib, $number - 1) + memo(fib, $number - 2)
EndFunc

Func fib_($number)	; Normal function
   if $number == 0 or $number == 1 Then
	  Return 1
   EndIf

   Return fib_($number - 1) + fib_( $number - 2)
EndFunc


Func factorial($n)	; Normal function
   if $n == 1 Then
	  Return 1
   EndIf

   Return Faculty($n - 1) * $n
EndFunc

Func factorial_($n)	; Memoizationed function
   if $n == 1 Then
	  Return 1
   EndIf

   Return memo(factorial_, $n - 1) * $n
EndFunc


Func collatz($n)	; Normal function
   if $n < 2 Then
	  Return 1
   ElseIf Mod($n, 2) == 0 Then
	  Return collatz($n / 2)
   Else
	  Return collatz(3 * $n + 1)
   EndIf
EndFunc

Func collatz_($n)	; Memoizationed function
   if $n < 2 Then
	  Return 1
   ElseIf Mod($n, 2) == 0 Then
	  Return memo(collatz_, $n / 2)
   Else
	  Return memo(collatz_, 3 * $n + 1)
   EndIf
EndFunc



ConsoleWrite(fib(10000))	; takes less than 6 seconds (on my machine)... would'nt be possible without memo..
ConsoleWrite(fib_(10000))	; recusion depth exceeded....

ConsoleWrite(collatz_(10000))	; no significant speedup for higher numbers, because of rapid decrease..
ConsoleWrite(collatz(10000))	; nearly as fast as above


$oDictionary.RemoveAll
