module bug183
  #(parameter NUM = 9       
    , WIDTH = 8             
    ) (  input logic  [NUM-1:0][WIDTH-1:0] a  
	 , output logic  [WIDTH-1:0]        sum 
	 );
   localparam NLOG =
                    (NUM <=     2) ?  1    
                    : (NUM <=  1024) ? 10  
                    : 0;                  
   typedef logic [WIDTH-1:0] val_t;
   val_t [NLOG:0][NUM-1:0] tree;
endmodule