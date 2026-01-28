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

  define i8 @foo() {
  entry:
  %t1 = add i8 2, 0
  ret i8 %t1
  }
  
  define void @main() {
  entry:
  %t2 = add i8 100, 0
  %t3 = call i8 @foo()
  %t4 = call i8 @foo()
  %t5 = sub i8 %t3, %t4
  %t6 = icmp eq i8 %t5, 0
  br i1 %t6, label %label_4, label %label_3
label_4:
  call void @print(i8* getelementptr ([23 x i8], [23 x i8]* @.str_div_err, i32 0, i32 0))
  call void @exit(i32 0)
  unreachable
label_3:
  %t7 = udiv i8 %t2, %t5
  %t8 = zext i8 %t7 to i32
  call void @printi(i32 %t8)
  }
  
