module fpll_dprio_init (
    input               clk,                
    input               reset_n,            
    input               locked,             
    output      [ 5:0]  dprio_address,      
    output              dprio_read,         
    output      [ 1:0]  dprio_byteen,       
    output              dprio_write,        
    output      [15:0]  dprio_writedata,    
    output  reg         atpgmode,           
    output  reg         mdio_dis,           
    output  reg         scanen,             
    output  reg         ser_shift_load,     
    output  reg         dprio_init_done     
);
    reg [1:0] rst_n = 2'b00;                
    reg [6:0] count = 7'd0;                 
    reg init_done_forever;                  
    wire  int_mdio_dis;
    wire  int_ser_shift_load;
    wire  int_dprio_init_done;
    wire  int_atpgmode;
    wire  int_scanen;
    assign  dprio_address   = count[6] ? 5'b0 : count[5:0]; 
    assign  dprio_byteen    = 2'b11;                        
    assign  dprio_write     = ~count[6] & reset_n;           
    assign  dprio_read      = 1'b0;                          
    assign  dprio_writedata = 16'd0;                         
    assign  int_ser_shift_load  = count[6] ? |count[2:1]  : 1'b1; 
    assign  int_mdio_dis        = count[6] ? ~count[2]    : 1'b1; 
    assign  int_dprio_init_done = ~init_done_forever ? (count[6] ? &count[2:0]  : 1'b0) : 1'b1; 
    assign  int_atpgmode        = 0;                               
    assign  int_scanen          = 0;                               
    initial begin
        count             = 7'd0;
        init_done_forever = 0;
        mdio_dis          = 1'b1;
        ser_shift_load    = 1'b1;
        dprio_init_done   = 1'b0;
        scanen            = 1'b0;
        atpgmode          = 1'b0;
    end
    always @(posedge clk or negedge reset_n)
        if(!reset_n)  rst_n <= 2'b00;       
        else          rst_n <= {rst_n[0],1'b1}; 
    always @(posedge clk)
    begin
        if (!rst_n[1])
            init_done_forever <= 1'b0;      
        else if (count[6] && &count[1:0])
            init_done_forever <= 1'b1;      
    end
    always @(posedge clk or negedge rst_n[1])
    begin
        if(!rst_n[1])
        begin
            count <= 7'd0;                  
        end
        else if(~int_dprio_init_done)
        begin
            count <= count + 7'd1;          
        end
        else
        begin
            count <= count;                 
        end
    end
    always @(posedge clk) begin
        mdio_dis        <= int_mdio_dis;            
        ser_shift_load  <= int_ser_shift_load;      
        dprio_init_done <= int_dprio_init_done;     
        atpgmode        <= int_atpgmode;            
        scanen          <= int_scanen;              
    end
endmodule