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

  define void @printByValue(i32) {
  entry:
  %t1 = alloca i32
  store i32 %0, i32* %t1
  %t2 = load i32, i32* %t1
  %t3 = icmp ne i32 %t2, 0
  br i1 %t3, label %label_2, label %label_3
label_2:
  %t4 = getelementptr [12 x i8], [12 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t4)
  br label %label_4
label_3:
  %t5 = getelementptr [13 x i8], [13 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t5)
  br label %label_4
label_4:
  ret void
  }
  
  define void @main() {
  entry:
  %t6 = add i32 1, 0
  call void @printByValue(i32 %t6)
  %t7 = add i32 0, 0
  call void @printByValue(i32 %t7)
  %t8 = add i32 1, 0
  %t9 = icmp ne i32 %t8, 0
  br i1 %t9, label %label_6, label %label_7
label_6:
  %t10 = getelementptr [5 x i8], [5 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t10)
  br label %label_8
label_7:
  br label %label_8
label_8:
  %t11 = alloca i32
  store i32 1, i32* %t11
  %t12 = add i32 0, 0
  %t13 = icmp ne i32 %t12, 0
  br i1 %t13, label %label_10, label %label_9
label_9:
  %t14 = add i32 0, 0
  %t15 = alloca i32
  store i32 0, i32* %t15
  %t16 = icmp ne i32 %t14, 0
  br i1 %t16, label %label_11, label %label_12
label_11:
  %t17 = add i32 1, 0
  store i32 %t17, i32* %t15
  br label %label_12
label_12:
  %t18 = load i32, i32* %t15
  store i32 %t18, i32* %t11
  br label %label_10
label_10:
  %t19 = load i32, i32* %t11
  %t20 = icmp ne i32 %t19, 0
  br i1 %t20, label %label_13, label %label_14
label_13:
  %t21 = getelementptr [5 x i8], [5 x i8]* @.str4, i32 0, i32 0
  call void @print(i8* %t21)
  br label %label_15
label_14:
  br label %label_15
label_15:
  ret void
  }
  
