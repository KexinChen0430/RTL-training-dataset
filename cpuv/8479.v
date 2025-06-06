module enc(rst_n, freq_clk, enable, pha, phb, home, index, led);
input rst_n;        
input freq_clk;     
input enable;       
output pha;         
output phb;         
output home;        
output index;       
output led;         
reg pha_reg;        
reg phb_reg;        
reg home_reg;       
reg index_reg;      
reg[7:0] pha_count; 
reg led;
reg [31:0] count_reg; 
reg out_200hz;        
always @(posedge freq_clk or negedge rst_n) begin
    if (!rst_n) begin 
        count_reg <= 0;      
        out_200hz <= 0;      
        count_reg <= 0;      
        out_200hz <= 0;      
    end
    else if (enable) begin 
        if (count_reg < 124999) begin 
            count_reg <= count_reg + 1; 
        end else begin 
            count_reg <= 0;            
            out_200hz <= ~out_200hz;   
        end
    end
end
always @ (posedge out_200hz or negedge rst_n)
begin
    if (!rst_n) begin 
        pha_count <= 8'd0; 
        led <= 1'b0;       
    end
    else if (out_200hz) begin 
        led <= ~led; 
        if(pha_count > 8'd24) 
            pha_count <= 8'd0; 
        else
            pha_count <= pha_count + 8'd1; 
    end
end
reg[1:0] Phase90_Count;
always @ (posedge out_200hz or negedge rst_n)
begin
    if (!rst_n) begin 
        Phase90_Count <= 2'b0; 
    end
    else if (out_200hz) begin 
        case (Phase90_Count) 
            2'd0: 
            begin
                pha_reg <=  1'd1; 
                Phase90_Count <= Phase90_Count + 2'd1; 
            end
            2'd1: 
            begin
                phb_reg <=  1'd1; 
                Phase90_Count <= Phase90_Count + 2'd1; 
            end
            2'd2: 
            begin
                pha_reg <=  1'd0; 
                Phase90_Count <= Phase90_Count + 2'd1; 
            end
            2'd3: 
            begin
                phb_reg <=  1'd0; 
                Phase90_Count <= 2'd0; 
            end
        endcase
    end
end
assign pha = pha_reg;
assign phb = phb_reg;
always @ (posedge out_200hz or negedge rst_n)
begin
    if (!rst_n) begin 
        home_reg <= 1'b0; 
    end
    else if (out_200hz) begin 
        case (pha_count) 
            8'd23: home_reg <=  1'd1; 
            8'd24: home_reg <=  1'd1; 
            default: home_reg <=  1'd0; 
        endcase
    end
end
assign home = home_reg;
always @ (posedge out_200hz or negedge rst_n)
begin
    if (!rst_n) begin 
        index_reg <= 1'b0; 
    end
    else if (out_200hz) begin 
        case (pha_count) 
            8'd23: index_reg <=  1'd1; 
            8'd24: index_reg <=  1'd1; 
            default: index_reg <=  1'd0; 
        endcase
    end
end
assign index = index_reg;
endmodule