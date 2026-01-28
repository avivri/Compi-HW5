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
@.str1 = constant [5 x i8] c"foo!\00"

  define void @foo() {
  entry:
  %t1 = getelementptr [5 x i8], [5 x i8]* @.str1, i32 0, i32 0
  call void @print(i8* %t1)
  ret void
  }
  
  define void @bar(i32) {
  entry:
  %t2 = alloca i32
  store i32 %0, i32* %t2
  %t3 = load i32, i32* %t2
  call void @printi(i32 %t3)
  ret void
  }
  
  define void @moo(i1) {
  entry:
  %t4 = alloca i1
  store i1 %0, i1* %t4
  %t5 = load i1, i1* %t4
  br i1 %t5, label %label_4, label %label_5
label_4:
  call void @foo()
  br label %label_6
label_5:
  %t6 = add i32 110, 0
  call void @bar(i32 %t6)
  br label %label_6
label_6:
  ret void
  }
  
  define void @main() {
  entry:
  call void @foo()
  %t7 = add i32 150, 0
  call void @bar(i32 %t7)
  %t8 = add i1 1, 0
  call void @moo(i1 %t8)
  call void @foo()
  %t9 = add i1 0, 0
  call void @moo(i1 %t9)
  ret void
  }
  
