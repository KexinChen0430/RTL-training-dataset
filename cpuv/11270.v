module Timer(
    dout,        
    din,         
    address,     
    size,        
    read_write,  
    enable,      
    interrupt,   
    reset,       
    clk          
);
    `include "definition/Definition.v"
    output  reg [WORD-1:0]             dout;       
    input   wire [WORD-1:0]            din;        
    input   wire [WORD-1:0]            address;    
    input   wire [LOGWORDBYTE-1:0]     size;       
    input   wire                       read_write; 
    input   wire                       enable;     
    output  reg                        interrupt;  
    input                              reset;      
    input                              clk;        
    localparam SETTHENSTART = 0;       
    localparam STOPTHENACQUIRE = 1;    
    reg [WORD-1:0] counter_upper;      
    reg [WORD-1:0] counter_lower;      
    reg [WORD-1:0] timer_upper;        
    reg [WORD-1:0] timer_lower;        
    wire set_then_start;               
    wire stop_then_acquire;            
    reg [(2*WORD)-1:0] counter;        
    reg [(2*WORD)-1:0] timer;          
    reg [(2*WORD)-1:0] interval;       
    always @(posedge clk) begin
        if(reset) begin
            dout <= 0;                 
        end
        else if((enable==ENABLE) && (read_write==READ)) begin
            case(address)              
                2: dout <= counter_upper;
                3: dout <= counter_lower;
                4: dout <= timer_upper;
                5: dout <= timer_lower;
                default: dout <= 0;    
            endcase
        end
        else begin
            dout <= 0;                 
        end
    end
    assign set_then_start = ((address==0) && (enable==ENABLE) && (read_write==WRITE) && (din==SETTHENSTART));
    assign stop_then_acquire = ((address==0) && (enable==ENABLE) && (read_write==WRITE) && (din==STOPTHENACQUIRE));
    always @(posedge clk) begin
        if(reset) begin
            counter_upper <= 0;
            counter_lower <= 0;
            timer_upper   <= 0;
            timer_lower   <= 0;
        end
        else if((enable==ENABLE) && (read_write==WRITE)) begin
            if((address==2))            counter_upper <= din;
            else if(stop_then_acquire)  counter_upper <= counter[(2*WORD)-1:WORD];
            else                        counter_upper <= counter_upper;
            if((address==3))            counter_lower <= din;
            else if(stop_then_acquire)  counter_lower <= counter[WORD-1:0];
            else                        counter_lower <= counter_lower;
            if((address==4))            timer_upper <= din;
            else if(stop_then_acquire)  timer_upper <= timer[(2*WORD)-1:WORD];
            else                        timer_upper <= timer_upper;
            if((address==5))            timer_lower <= din;
            else if(stop_then_acquire)  timer_lower <= timer[WORD-1:0];
            else                        timer_lower <= timer_lower;
        end
    end
    always @(posedge clk) begin
        if(reset) begin
            counter   <= 0;
            timer     <= 0;
            interval  <= 0;
            interrupt <= 0;
        end
        else if(set_then_start) begin
            counter   <= {counter_upper, counter_lower};
            timer     <= {timer_upper, timer_lower};
            interval  <= {timer_upper, timer_lower};
            interrupt <= 0;
        end
        else if(stop_then_acquire) begin
            counter   <= 0;
            timer     <= 0;
            interval  <= 0;
            interrupt <= 0;
        end
        else if((timer==0) && (counter==0)) begin
            counter   <= 0;
            timer     <= 0;
            interval  <= 0;
            interrupt <= 0;
        end
        else if((timer==0) && (counter==1)) begin
            counter   <= 0;
            timer     <= 0;
            interval  <= 0;
            interrupt <= 1;
        end
        else if((timer==0)) begin
            counter   <= counter - 1;
            timer     <= interval;
            interval  <= interval;
            interrupt <= 1;
        end
        else begin
            counter   <= counter;
            timer     <= timer - 1;
            interval  <= interval;
            interrupt <= 0;
        end
    end
endmodule