package com.fastcms.common.qrcode;



import java.util.Scanner;

public class QRCodeutilDemo {
    public static void main(String[] args) throws Exception {
            // 存放在二维码中的内容
            // 二维码中的内容可以是文字，可以是链接等
        Scanner scanner = new Scanner(System.in);
        System.out.println("请输入内容");
        String text = scanner.nextLine();
        System.out.println("请输入二维码名称");
        String name = scanner.nextLine();
        //  String text = "https://popyey.gitee.io/";
            // 嵌入二维码的图片路径
           // String imgPath = "C:\\Users\\用户名\\Pictures\\MyCam\\imag\\logo.png";
            // 生成的二维码的路径及名称
          //  String destPath = "C:\\Users\\用户名\\Pictures\\MyCam\\imag" + System.currentTimeMillis() + ".jpg";
           String destPath = "C:\\Users\\23917\\Pictures\\MyCam\\imag" +name + ".jpg";
            //生成二维码
            QRCodeUtil.encode(text, null, destPath, true);
            // 解析二维码
            String str = QRCodeUtil.decode(destPath);
            // 打印出解析出的内容
            System.out.println(str);

    }
}
