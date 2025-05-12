module COMPARE
    #(parameter DEPTH = 10, 
               ALMOST_FULL = 4 )
    (input  [DEPTH:0] wptr, 
     input  [DEPTH:0] rptr, 
     output wire      empty, 
     output wire      full); 
    assign empty = (wptr[DEPTH:0] == rptr[DEPTH:0]);
    assign full  = (wptr[DEPTH] != rptr[DEPTH]) & (wptr[DEPTH-1: ALMOST_FULL] == rptr[DEPTH-1: ALMOST_FULL]);
    always@(full or empty) begin
        $display("current depth is %0d, current empty is %0d, current full is %0d", DEPTH, empty, full);
    end
endmodule 