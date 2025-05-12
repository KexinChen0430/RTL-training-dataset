module Simple_KOA
    #(parameter SW = 24) 
    (
    input wire [SW-1:0] Data_A_i, 
    input wire [SW-1:0] Data_B_i, 
    output reg [2*SW-1:0] sgf_result_o 
    );
    wire [1:0] zero1; 
    wire [3:0] zero2; 
    assign zero1 = 2'b00; 
    assign zero2 = 4'b0000; 
    wire [SW/2-1:0] rightside1; 
    wire [SW/2:0] rightside2; 
    wire [SW/2-3:0] leftside1; 
    wire [SW/2-4:0] leftside2; 
    reg [4*(SW/2)-1:0] sgf_r; 
    assign rightside1 = {(SW/2){1'b0}}; 
    assign rightside2 = {(SW/2+1){1'b0}}; 
    assign leftside1 = {(SW/2-2){1'b0}}; 
    assign leftside2 = {(SW/2-1){1'b0}}; 
    localparam half = SW/2; 
generate 
    if (SW <=`STOP_SW1 || SW <=`STOP_SW2) begin : GENSTOP 
        always @* begin : STOP1 
             sgf_result_o <= Data_A_i * Data_B_i; 
        end
    end else begin  : RECURSIVE 
    case (SW%2) 
        0:begin : EVEN1 
            reg [SW/2:0] result_A_adder; 
            reg [SW/2:0] result_B_adder; 
            reg [SW-1:0] Q_left; 
            reg [SW-1:0] Q_right; 
            reg [SW+1:0] Q_middle; 
            reg [2*(SW/2+2)-1:0] S_A; 
            reg [2*(SW/2+2)-1:0] S_B; 
            always@(posedge clk) begin : EVEN12 
                 Q_middle  <= result_A_adder * result_B_adder; 
                 Q_left [SW-1:0] <= Data_A_i[(SW-1) -: SW/2] * Data_B_i[(SW-1) -: SW/2]; 
                 Q_right[SW-1:0] <= Data_A_i[((SW/2)-1):0]  * Data_B_i[((SW/2)-1):0]; 
            end
           always @* begin : EVEN 
                 result_A_adder <= (Data_A_i[((SW/2)-1):0] + Data_A_i[(SW-1) -: SW/2]); 
                 result_B_adder <= (Data_B_i[((SW/2)-1):0] + Data_B_i[(SW-1) -: SW/2]); 
                 S_B <= (Q_middle - (Q_left + {zero1,Q_right})); 
                 sgf_result_o[2*SW-1:0] <= {S_B[2*(SW/2)+1:0],rightside1} + {Q_left,Q_right[2*(SW/2)-1:0]}; 
           end
        end
        1:begin : ODD1 
            always@(posedge clk) begin : ODD12 
                 Q_middle  <= result_A_adder * result_B_adder; 
                 Q_left  <= Data_A_i[SW-1:SW/2+1] * Data_B_i[SW-1:SW/2+1]; 
                 Q_right <= Data_A_i[SW/2:0]      * Data_B_i[SW/2:0]; 
            end
            always @* begin : ODD 
                reg [SW/2+1:0] result_A_adder; 
                reg [SW/2+1:0] result_B_adder; 
                reg [2*(SW/2)-1:0]   Q_left; 
                reg [2*(SW/2+1)-1:0] Q_right; 
                reg [2*(SW/2+2)-1:0] Q_middle; 
                reg [2*(SW/2+2)-1:0] S_A; 
                reg [2*(SW/2+2)-1:0] S_B; 
                 result_A_adder <= (Data_A_i[SW-SW/2-1:0] + Data_A_i[SW-1:SW-SW/2]); 
                 result_B_adder <= Data_B_i[SW-SW/2-1:0] + Data_B_i[SW-1:SW-SW/2]; 
                 S_B <= (Q_middle - (Q_left + Q_right)); 
                 sgf_result_o<= {S_B,rightside2} + {Q_left,Q_right}; 
            end
        end
    endcase
end
endgenerate
endmodule