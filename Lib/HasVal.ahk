; Credit to jNizM https://www.autohotkey.com/boards/viewtopic.php?p=109617&sid=a057c8ab901a3ab88f6304b71729c892#p109617

HasVal(haystack, needle) {
	If !(IsObject(haystack)) || (haystack.Length() = 0)
		Return 0
	for index, value in haystack
		If (value = needle)
			Return index
	Return 0
}