package utils;

import java.util.Scanner;

public class task1to5 {
    private static Scanner sc;
    public static void main(String[] args)
    {
        sc=new Scanner(System.in);
        //task2 simpleCalculator();
        //task3 oddOrEven();
        //task4 Leap();
        sc.close();
    }
     public static void simpleCalculator(){

        System.out.println("Enter a:");
        int a=sc.nextInt();
        System.out.println("Enter b:");
        int b=sc.nextInt();
        System.out.println("Enter Operator (1-add 2-sub 3-mul 4-div):");
        int op=sc.nextInt();
        if (op==1)
                System.out.println("Result"+(a+b));
        else if (op==2)
                System.out.println("Result"+(a-b));
        else if (op==3)
            System.out.println("Result"+(a*b));
        else if (op==4)
            System.out.println("Result"+(a/b));
     }
    public static void oddOrEven(){
        System.out.println("Enter a number:");
        int a=sc.nextInt();
        System.out.println(a%2 ==0 ? "Even":"Odd");
    }
    public static void Leap(){
        System.out.println("Enter a year:");
        int a=sc.nextInt();
        if( (a%4==0 && a%100 !=0) ||(a%400 == 0) )
            System.out.println("Leap");
        else
            System.out.println("Not Leap");
    }


}
