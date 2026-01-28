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
@.str1 = constant [12 x i8] c"val is true\00"
@.str2 = constant [13 x i8] c"val is false\00"
@.str3 = constant [5 x i8] c"true\00"
@.str4 = constant [5 x i8] c"true\00"

  define void @printByValue(i1) {
  entry:
  %t1 = alloca i1
  store i1 %0, i1* %t1
  %t2 = load i1, i1* %t1
  br i1 %t2, label %label_2, label %label_3
label_2:
  %t3 = getelementptr [12 x i8], [12 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t3)
  br label %label_4
label_3:
  %t4 = getelementptr [13 x i8], [13 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t4)
  br label %label_4
label_4:
  ret void
  }
  
  define void @main() {
  entry:
  %t5 = add i1 1, 0
  call void @printByValue(i1 %t5)
  %t6 = add i1 0, 0
  call void @printByValue(i1 %t6)
  %t7 = add i1 1, 0
  br i1 %t7, label %label_6, label %label_7
label_6:
  %t8 = getelementptr [5 x i8], [5 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t8)
  br label %label_8
label_7:
  br label %label_8
label_8:
  %t9 = alloca i1
  store i1 1, i1* %t9
  %t10 = add i1 0, 0
  br i1 %t10, label %label_10, label %label_9
label_9:
  %t11 = add i1 0, 0
  %t12 = alloca i1
  store i1 0, i1* %t12
  br i1 %t11, label %label_11, label %label_12
label_11:
  %t13 = add i1 1, 0
  store i1 %t13, i1* %t12
  br label %label_12
label_12:
  %t14 = load i1, i1* %t12
  store i1 %t14, i1* %t9
  br label %label_10
label_10:
  %t15 = load i1, i1* %t9
  br i1 %t15, label %label_13, label %label_14
label_13:
  %t16 = getelementptr [5 x i8], [5 x i8]* @.str4, i32 0, i32 0
  call void @print(i8* %t16)
  br label %label_15
label_14:
  br label %label_15
label_15:
  ret void
  }
  
