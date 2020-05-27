package com.csumb.cst363.project1;

public class PharmacyReport
{
   String name = "";
   int quantity = 0;
   
   public PharmacyReport(String name, int quantity)
   {
      super();
      this.name = name;
      this.quantity = quantity;
   }
   
   public String getName()
   {
      return name;
   }
   public void setName(String name)
   {
      this.name = name;
   }
   public int getQuantity()
   {
      return quantity;
   }
   public void setQuantity(int quantity)
   {
      this.quantity = quantity;
   }  
   
}
