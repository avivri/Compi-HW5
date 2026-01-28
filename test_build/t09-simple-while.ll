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
  %t1 = add i1 0, 0
  br i1 %t1, label %label_3, label %label_4
label_3:
  %t2 = getelementptr [29 x i8], [29 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t2)
  br label %label_2
label_4:
  %t3 = alloca i32
  %t4 = add i32 0, 0
  store i32 %t4, i32* %t3
  br label %label_5
label_5:
  %t5 = load i32, i32* %t3
  %t6 = add i32 10, 0
  %t7 = icmp slt i32 %t5, %t6
  br i1 %t7, label %label_6, label %label_7
label_6:
  %t8 = load i32, i32* %t3
  call void @printi(i32 %t8)
  %t9 = load i32, i32* %t3
  %t10 = add i32 1, 0
  %t11 = add i32 %t9, %t10
  store i32 %t11, i32* %t3
  br label %label_5
label_7:
  ret void
  }
  
