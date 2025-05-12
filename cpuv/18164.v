module up_down_counter
    #(parameter DEFAULT=8'd100) ( 
    input logic clk, rst_n, clr, en, 
    input logic count_up, count_down, 
    output logic [9:0] count 
    );
    always_ff @(posedge clk) begin
        if (~rst_n) 
            count <= DEFAULT; 
        else if (clr) 
            count <= DEFAULT; 
        else if (en) begin 
            if (count_up) 
                count <= count + 1'b1; 
            else if (count_down) 
                count <= count - 1'b1; 
        end
    end
endmodule