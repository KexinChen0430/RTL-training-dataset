module enums; 
   enum {red, yellow, green} light;
   enum integer {IDLE, XX='x, S1='b01, S2='b10} state, next;
   enum {bronze=3, silver, gold} medal;
   enum { add=10, sub[5], jmp[6:8] } E1;
   typedef enum {NOPE, YUP} boolean;
   enum  logic [1:0] {IDLE, DIR} STATE, NSTATE;
endmodule 