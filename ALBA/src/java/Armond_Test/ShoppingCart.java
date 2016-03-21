/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Armond_Test;

/**
 *
 * @author armondluthens
 */
public class ShoppingCart {
    public String name;
    public String productID;
    public String qty;
    public float itemPrice;
    public float totalPrice;
    
    public ShoppingCart(){
    
    }
    public ShoppingCart(String name, String id, String qty, float itemPrice, float totalPrice){
            this.name = name;
            this.productID = id;
            this.qty = qty;
            this.itemPrice = itemPrice;
            this.totalPrice = totalPrice;
    }
    
    public String getName(){
        return name;
    }
    public String getID(){
        return productID;
    }
    public String getQty(){
        return qty;
    }
    public float getItemPrice(){
        return itemPrice;
    }
    public float getTotalPrice(){
        return totalPrice;
    }
}
