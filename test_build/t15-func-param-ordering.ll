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
@.str1 = constant [4 x i8] c"f1!\00"
@.str2 = constant [4 x i8] c"f2!\00"
@.str3 = constant [4 x i8] c"f3!\00"
@.str4 = constant [14 x i8] c"call me maybe\00"

  define i32 @f1(i32) {
  entry:
  %t1 = alloca i32
  store i32 %0, i32* %t1
  %t2 = getelementptr [4 x i8], [4 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t2)
  %t3 = load i32, i32* %t1
  ret i32 %t3
label_2:
  ret i32 0
  }
  
  define i32 @f2(i32) {
  entry:
  %t4 = alloca i32
  store i32 %0, i32* %t4
  %t5 = getelementptr [4 x i8], [4 x i8]* @.str2, i32 0, i32 0
  call void @print(i8* %t5)
  %t6 = load i32, i32* %t4
  ret i32 %t6
label_4:
  ret i32 0
  }
  
  define i32 @f3(i32) {
  entry:
  %t7 = alloca i32
  store i32 %0, i32* %t7
  %t8 = getelementptr [4 x i8], [4 x i8]* @.str3, i32 0, i32 0
  call void @print(i8* %t8)
  %t9 = load i32, i32* %t7
  ret i32 %t9
label_6:
  ret i32 0
  }
  
  define void @callMe(i32, i32, i32, i32, i32, i32, i32, i32) {
  entry:
  %t10 = alloca i32
  store i32 %0, i32* %t10
  %t11 = alloca i32
  store i32 %1, i32* %t11
  %t12 = alloca i32
  store i32 %2, i32* %t12
  %t13 = alloca i32
  store i32 %3, i32* %t13
  %t14 = alloca i32
  store i32 %4, i32* %t14
  %t15 = alloca i32
  store i32 %5, i32* %t15
  %t16 = alloca i32
  store i32 %6, i32* %t16
  %t17 = alloca i32
  store i32 %7, i32* %t17
  %t18 = getelementptr [14 x i8], [14 x i8]* @.str4, i32 0, i32 0
  call void @print(i8* %t18)
  %t19 = load i32, i32* %t10
  call void @printi(i32 %t19)
  %t20 = load i32, i32* %t11
  call void @printi(i32 %t20)
  %t21 = load i32, i32* %t12
  call void @printi(i32 %t21)
  %t22 = load i32, i32* %t15
  call void @printi(i32 %t22)
  %t23 = load i32, i32* %t16
  call void @printi(i32 %t23)
  ret void
  }
  
  define void @main() {
  entry:
  %t24 = add i32 2, 0
  %t25 = call i32 @f1(i32 %t24)
  %t26 = add i32 4, 0
  %t27 = call i32 @f2(i32 %t26)
  %t28 = add i32 5, 0
  %t29 = call i32 @f2(i32 %t28)
  %t30 = add i32 1, 0
  %t31 = call i32 @f3(i32 %t30)
  %t32 = add i32 0, 0
  %t33 = call i32 @f3(i32 %t32)
  %t34 = add i32 3, 0
  %t35 = call i32 @f2(i32 %t34)
  %t36 = add i32 22, 0
  %t37 = call i32 @f1(i32 %t36)
  %t38 = add i32 0, 0
  %t39 = call i32 @f3(i32 %t38)
  call void @callMe(i32 %t25, i32 %t27, i32 %t29, i32 %t31, i32 %t33, i32 %t35, i32 %t37, i32 %t39)
  ret void
  }
  
