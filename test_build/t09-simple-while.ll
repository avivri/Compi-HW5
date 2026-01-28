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
@.str1 = constant [29 x i8] c"never gonna happen hopefully\00"

  define void @main() {
  entry:
  br label %label_2
label_2:
  %t1 = add i32 0, 0
  %t2 = icmp ne i32 %t1, 0
  br i1 %t2, label %label_3, label %label_4
label_3:
  %t3 = getelementptr [29 x i8], [29 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t3)
  br label %label_2
label_4:
  %t4 = alloca i32
  %t5 = add i32 0, 0
  store i32 %t5, i32* %t4
  br label %label_5
label_5:
  %t6 = load i32, i32* %t4
  %t7 = add i32 10, 0
  %t8 = icmp slt i32 %t6, %t7
  %t9 = zext i1 %t8 to i32
  %t10 = icmp ne i32 %t9, 0
  br i1 %t10, label %label_6, label %label_7
label_6:
  %t11 = load i32, i32* %t4
  call void @printi(i32 %t11)
  %t12 = load i32, i32* %t4
  %t13 = add i32 1, 0
  %t14 = add i32 %t12, %t13
  store i32 %t14, i32* %t4
  br label %label_5
label_7:
  ret void
  }
  
