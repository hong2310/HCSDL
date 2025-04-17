import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.util.ArrayList;
import java.util.Scanner;

public class Cau2 {
    public static void main(String[] args) throws FileNotFoundException {
        ArrayList<String> data = new ArrayList<>();
        Scanner sc= new Scanner(System.in);
        data = readFile("input/file2.txt");
        System.out.println(data);
        ArrayList<String> phuthuoc= new ArrayList<>();
        phuthuoc=PhuThuocHam(data);
        String attr=attribute(data.get(0).trim());
        ArrayList<String> Khoa=timKhoa(attr, phuthuoc);
        show(Khoa);
        
        
    }
    private static void show(ArrayList<String> khoa) {
        String s="";
        for(String k:khoa){
            String temp="";
                 for(int i=0;i<k.length();i++){
                     if(k.charAt(i)!=','){
                         temp=temp+k.charAt(i);
                     }
             }
            s=s+temp+",";
        }
        System.out.println("{ "+s+" }");
    }
    private static ArrayList<String> timKhoa(String attr,ArrayList<String> pt) {
        ArrayList<String> N=new ArrayList<>();
        ArrayList<String> D=new ArrayList<>();
        ArrayList<String> L= new ArrayList<>();
        ArrayList<String> K= new ArrayList<>();
        String Tvp="",Tvt="";
            for(String s:pt){
                    String s1[]=s.split(":");
                    String vp=s1[1].trim();
                    String vt=s1[0].trim();
                    Tvp=Tvp+vp;
                    Tvt=Tvt+vt;

            }
        for (int i = 0; i < attr.length(); i++) {
            if(!xoaTrung(Tvp).contains(attr.charAt(i)+"") ||(!xoaTrung(Tvp).contains(attr.charAt(i)+"") && !xoaTrung(Tvt).contains(attr.charAt(i)+""))){
                N.add(attr.charAt(i)+"");
            }
            if(!xoaTrung(Tvt).contains(attr.charAt(i)+""))
            {
                D.add(attr.charAt(i)+"");
            }
            if (xoaTrung(Tvp).contains(attr.charAt(i)+"") && xoaTrung(Tvt).contains(attr.charAt(i)+"")){
                L.add(attr.charAt(i)+"");
            }
        }
        ArrayList<String> temp= new ArrayList<>();
        String s="";
        for(String k:N){
            s=s+","+k;
        }
        for(String i:L){
            String x=s;
            x=x+","+i;
            temp.add(x.substring(1));
        }
       for(String i: temp){
            if(baodong(pt,i).length()==attr.length()){
                K.add(i);
            }
       }
       return K;
    }
    private static String attribute(String s) {
        String re="";
        String temp=s.substring(2,s.length()-1);
        for(int i=0;i<temp.length();i++){
            if(!(temp.charAt(i)==','))
            {   
                re=re+temp.charAt(i);
            }
        }
       return re;
    }
    private static String baodong(ArrayList<String> pt,String c) {
        String re="";
        //System.out.println(pt);
        if(c.length()>1){
            String tt[]=c.split(",");
            for (int i=0;i<tt.length;i++){
                re=re+tt[i].toUpperCase();
            }
            for(int i=0;i<tt.length;i++){
                for(String s:pt){
                    String s1[]=s.split(":");
                    String vt=s1[0];
                    String vp=s1[1];
                    if(vt.equals(tt[i].toUpperCase())){
                        re=re+vp;
                    }
                }
            }
            for(int i=0;i<pt.size();i++){
                for(String s:pt){
          //          System.out.println(s);
                        String s1[]=s.split(":"); 
                        String vt=s1[0].trim(); //gh
            //            System.out.println(vt);
                        String vp=s1[1].trim(); //C
                        boolean flag=true;
                        for (int j=0;j<vt.length();j++){ // =
                           //System.out.println(vt.charAt(j)+"/"+re.indexOf(vt.charAt(j)+""));
                            if(re.indexOf(vt.charAt(j)+"")==-1){
                                
                                flag=false;
                            }
                        }
                        if(flag){
                            re=re+vp;
                        }
            }
            
            }
        }
        else {
            re=c.toUpperCase();
            for(String s:pt){
                    String s1[]=s.split(":");
                    String vt=s1[0];
                    String vp=s1[1];
                    if(vt.equals(c.toUpperCase())){
                        re=re+vp;
                    }
                }
        }
        return xoaTrung(re);
    }
    public static String xoaTrung(String str) {
        String re="";
        for(int i=0;i<str.length();i++){
            if(!re.contains(str.charAt(i)+"")){
                re=re+str.charAt(i);
            }
        }
        return re;
    }
    public static ArrayList<String> PhuThuocHam(ArrayList<String> data) {
        String arr[]=data.get(1).trim().split(",");
        ArrayList<String> phuthuoc= new ArrayList<>();
        String tmp=arr[0].trim();
        String temp="";
        
        for(int i=0;i<tmp.length();i++){
            if(tmp.charAt(i)=='{'){
                temp=tmp.substring(i+1, tmp.length());
            }
            
        }
        phuthuoc.add(temp);
        for(int i=1;i<arr.length-1;i++){
            phuthuoc.add(arr[i]);
        }
        String tmp1=arr[arr.length-1];
        phuthuoc.add(tmp1.substring(0,tmp1.length()-1));
        return phuthuoc;
    }
    private static ArrayList<String> readFile(String path) throws FileNotFoundException {
        FileInputStream file = new FileInputStream(path);
        Scanner sc = new Scanner(file);
        ArrayList<String> result = new ArrayList<>();
        try {
            while (sc.hasNextLine()) {
                String temp = sc.nextLine();
                result.add(temp);
            }
            sc.close();
        } catch (Exception e) {
            System.out.println(e);
        }
        return result;
    }
}