module atm_pager(
    input  wire rst_n,               
    input  wire fclk,                
    input  wire zpos,                
    input  wire zneg,                
    input  wire [15:0] za,           
    input  wire [ 7:0] zd,           
    input  wire        mreq_n,       
    input  wire        rd_n,         
    input  wire        m1_n,         
    input  wire        pager_off,    
    input  wire        pent1m_ROM,   
    input  wire [ 5:0] pent1m_page,  
    input  wire        pent1m_ram0_0,
    input  wire        pent1m_1m_on, 
    input  wire        in_nmi,       
    input  wire        atmF7_wr,     
    input  wire        dos,          
    output wire        dos_turn_on,  
    output wire        dos_turn_off, 
    output wire        zclk_stall,   
    output reg  [ 7:0] page,         
    output reg         romnram,      
    output wire [ 7:0] rd_page0,     
    output wire [ 7:0] rd_page1,     
    output wire [ 1:0] rd_dos7ffd,   
    output wire [ 1:0] rd_ramnrom    
);
    parameter ADDR = 2'b00;
    reg [ 7:0] pages [0:1];         
    reg [ 1:0] ramnrom;             
    reg [ 1:0] dos_7ffd;            
    reg mreq_n_reg, rd_n_reg, m1_n_reg;
    wire dos_exec_stb, ram_exec_stb;
    reg [2:0] stall_count;
    assign rd_page0 = pages[0];
    assign rd_page1 = pages[1];
    assign rd_dos7ffd = dos_7ffd;
    assign rd_ramnrom = ramnrom;
    always @(posedge fclk)
    begin
        if( pager_off )
        begin 
            romnram <= 1'b1;
            page    <= 8'hFF;
        end
        else 
        begin
            if( (ADDR==2'b00) && (pent1m_ram0_0 || in_nmi) ) 
            begin
                if( in_nmi )
                begin
                    romnram <= 1'b0;
                    page    <= 8'hFF; 
                end
                else 
                begin
                    romnram <= 1'b0;
                    page    <= 8'd0; 
                end
            end
            else 
            begin
                romnram <= ~ramnrom[ pent1m_ROM ];
                if( dos_7ffd[ pent1m_ROM ] ) 
                begin
                    if( ramnrom[ pent1m_ROM ] )
                    begin 
                        if( pent1m_1m_on )
                        begin 
                            page <= { pages[ pent1m_ROM ][7:6], pent1m_page[5:0] };
                        end
                        else 
                        begin
                            page <= { pages[ pent1m_ROM ][7:3], pent1m_page[2:0] };
                        end
                    end
                    else 
                    begin
                        page <= { pages[ pent1m_ROM ][7:1], dos };
                    end
                end
                else 
                begin
                    page <= pages[ pent1m_ROM ];
                end
            end
        end
    end
    always @(posedge fclk) if( atmF7_wr )
    begin
        if( za[15:14]==ADDR )
        begin
            if( za[11] ) 
            begin
                pages   [ pent1m_ROM ] <= ~{ 2'b11, zd[5:0] };
                ramnrom [ pent1m_ROM ] <= zd[6];
                dos_7ffd[ pent1m_ROM ] <= zd[7];
            end
            else 
            begin
                pages   [ pent1m_ROM ] <= ~zd;
                ramnrom [ pent1m_ROM ] <= 1'b1; 
            end
        end
    end
`ifdef SIMULATE
    initial
    begin
        m1_n_reg   = 1'b1;
        mreq_n_reg = 1'b1;
        rd_n_reg   = 1'b1;
        stall_count = 3'b000;
    end
`endif
    always @(posedge fclk) if( zpos )
    begin
        m1_n_reg <= m1_n;
    end
    always @(posedge fclk) if( zneg )
    begin
        mreq_n_reg <= mreq_n;
    end
    assign dos_exec_stb = zneg && (za[15:14]==ADDR) &&
                          (!m1_n_reg) && (!mreq_n) && mreq_n_reg &&
                          (za[13:8]==6'h3D) &&
                          dos_7ffd[1'b1] && (!ramnrom[1'b1]) && pent1m_ROM;
    assign ram_exec_stb = zneg && (za[15:14]==ADDR) &&
                          (!m1_n_reg) && (!mreq_n) && mreq_n_reg &&
                          ramnrom[pent1m_ROM];
    assign dos_turn_on  = dos_exec_stb;
    assign dos_turn_off = ram_exec_stb;
    always @(posedge fclk)
    begin
        if( dos_turn_on )
        begin
            stall_count[2] <= 1'b1; 
            stall_count[0] <= 1'b1;
        end
        else if( stall_count[2] )
        begin
            stall_count[2:0] <= stall_count[2:0] + 3'd1;
        end
    end
    assign zclk_stall = dos_turn_on | stall_count[2];
endmodule