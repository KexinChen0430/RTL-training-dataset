module mux8x0 (
    output Q,      
    input  S0,     
    S1,            
    S2,            
    A,             
    B,             
    C,             
    D,             
    E,             
    F,             
    G,             
    H              
);
  specify
    (S0 => Q) = 1593;  
    (S1 => Q) = 1437;  
    (S2 => Q) = 995;   
    (A => Q) = 1887;   
    (B => Q) = 1873;   
    (C => Q) = 1856;   
    (D => Q) = 1860;   
    (E => Q) = 1714;   
    (F => Q) = 1773;   
    (G => Q) = 1749;   
    (H => Q) = 1723;   
  endspecify
  assign Q = S2 ? (S1 ? (S0 ? H : G) : (S0 ? F : E)) : (S1 ? (S0 ? D : C) : (S0 ? B : A));
endmodule