module that letter_div is sending letters to it.
    reg [7:0] letter_out_reg;            
    reg data_wr_0;                       
    reg data_wr_1;                       
    reg data_wr_2;                       
    reg data_wr_3;                       
    reg data_wr_4;                       
    reg data_wr_5;                       
    reg data_wr_6;                       
    reg data_wr_7;                       
    reg letter_out_en;                   
    reg letter_out_en_1;                 
    assign out_en = letter_out_en;       
    always@(posedge clk or negedge rst)
        if(!rst)
            data_wr_0 <= 0;
        else
            data_wr_0 <= data_wr;
    always@(posedge clk or negedge rst)
        if(!rst)
            data_wr_1 <= 0;
        else
            data_wr_1 <= data_wr_0;
    always@(posedge clk or negedge rst)
        if(!rst)
            letter_out_en <= 0;
        else if(data_wr_1)
            letter_out_en <= 1;
        else if(data_wr_6)
            letter_out_en <= 0;
    always@(posedge clk or negedge rst)
        if(!rst)
            letter_out_en_1 <= 0;
        else if(data_wr_2)
            letter_out_en_1 <= 1;
        else if(data_wr_6)
            letter_out_en_1 <= 0;
    assign letter_out = letter_out_en_1 == 1 ? letter_out_reg : 8'bzzzzzzzz;
    reg [data_size-1:0] mem_receive;     
    reg [7:0] mem_letter [1023:0];       
    reg [4:0] current_state;             
    reg [3:0] next_state;                
    reg [3:0] check_pt;                  
    reg [9:0] letter_pt;                 
    reg [9:0] out_pt;                    
    always@(posedge clk or negedge rst)
        if(!rst)
            out_pt <= 0;
        else
            out_pt <= letter_pt;
    always@(posedge clk or negedge rst)
        if(!rst)
            letter_out_reg <= 8'h00;
        else
            letter_out_reg <= mem_letter[out_pt];
    always@(posedge clk or negedge rst)
        if(!rst)
            current_state <= IDLE;
        else
            current_state <= next_state;
    always@*
        begin
            case(current_state)
            endcase
        end
    always@(posedge clk)
        case(current_state)
        endcase
endmodule