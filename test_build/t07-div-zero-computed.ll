declare i32 @printf(i8*, ...)
declare void @exit(i32)
@.int_specifier = constant [4 x i8] c"%d\0A\00"
@.str_specifier = constant [4 x i8] c"%s\0A\00"
define void @printi(i32) {
  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.int_specifier, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %spec_ptr, i32 %0)
  ret void
}
define void @print(i8*) {
  %spec_ptr = getelementptr [4 x i8], [4 x i8]* @.str_specifier, i32 0, i32 0
  call i32 (i8*, ...) @printf(i8* %spec_ptr, i8* %0)
  ret void
}
@.str_div_err = constant [23 x i8] c"Error division by zero\00"

  define i32 @foo() {
  entry:
  %t1 = add i32 2, 0
  ret i32 %t1
label_2:
  ret i32 0
  }
  
  define void @main() {
  entry:
  %t2 = add i32 100, 0
  %t3 = call i32 @foo()
  %t4 = call i32 @foo()
  %t5 = sub i32 %t3, %t4
  %t6 = and i32 %t5, 255
  %t7 = icmp eq i32 %t6, 0
  br i1 %t7, label %label_5, label %label_4
label_5:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_4:
  %t8 = udiv i32 %t2, %t6
  %t9 = and i32 %t8, 255
  call void @printi(i32 %t9)
  ret void
  }
  
