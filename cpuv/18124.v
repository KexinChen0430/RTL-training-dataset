module pc_cell (
    input       `control_w  c0_in,      
    input       `control_w  c1_in,      
    input       [1:0]       portno0,    
    input       [1:0]       portno1,    
    input       [1:0]       rr,         
    output      `control_w  ch_out,     
    output      `control_w  cl_out,     
    output      [1:0]       portno_h,   
    output      [1:0]       portno_l);  
    wire        valid0, valid1;         
    wire        gold0, gold1;           
    wire `seq_w seq0, seq1;             
    wire        winner;                 
    assign valid0 = c0_in[`valid_f];
    assign valid1 = c1_in[`valid_f];
    assign gold0 = c0_in[`gold_f];
    assign gold1 = c1_in[`gold_f];
    assign seq0 = c0_in[`seq_f];
    assign seq1 = c1_in[`seq_f];
    assign winner = (valid0 && ~valid1) ? 1'b0 :    
                    (~valid0 && valid1) ? 1'b1 :    
                    (~valid0 && ~valid1) ? 1'b1 :   
                    (gold0 && ~gold1) ? 1'b0 :      
                    (~gold0 && gold1) ? 1'b1 :      
                    (gold0 && gold1) ?              
                        ((seq0 < seq1) ? 1'b0 :     
                         (seq0 > seq1) ? 1'b1 : 1'b1) : 
                    ((rr - portno0) < (rr - portno1)) ? 1'b0 : 1'b1; 
    assign portno_h = (winner == 1'b1) ? portno1 : portno0; 
    assign portno_l = (winner == 1'b1) ? portno0 : portno1; 
    assign ch_out = (winner == 1'b1) ? c1_in : c0_in;       
    assign cl_out = (winner == 1'b1) ? c0_in : c1_in;       
endmodule