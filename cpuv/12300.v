module bus 
    begin 
        case( dma_module_select ) 
        DMA_MODULE_ZX: 
            dma_dout_modules <= dma_dout_zx; 
        DMA_MODULE_SD: 
            dma_dout_modules <= dma_dout_sd; 
        DMA_MODULE_MP3: 
            dma_dout_modules <= dma_dout_mp3; 
        default: 
            dma_dout_modules <= 8'bxxxxxxxx; 
        endcase 
    end 
    always @(posedge cpu_clock,negedge rst_n) 
    if( !rst_n ) 
        timer_rate <= 3'b000; 
    else if( p_timfreq_wr ) 
        timer_rate <= din[2:0]; 
endmodule 