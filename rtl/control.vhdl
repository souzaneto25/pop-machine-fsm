LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY control IS
    PORT (
        --clock e reset de entradas
        clk : IN STD_LOGIC;
        rst : IN STD_LOGIC;
        --sensor da moeda
        c : IN STD_LOGIC;
        --total menor que o preço do refrigerante
        tot_lt_s : IN STD_LOGIC;
        --total igual ao preço do refrigerante
        tot_eq_s : IN STD_LOGIC;
        --total maior que o preço do refrigerante
        tot_hg_s : IN STD_LOGIC;
        --saida da maquina
        d : OUT STD_LOGIC;
        --carrega o resultado da soma no registrador
        tot_ld : OUT STD_LOGIC;
        --aplica o clear no registrador tot
        tot_clr : OUT STD_LOGIC
    );
END ENTITY control;

ARCHITECTURE arch OF control IS

    --Tipagem dos estados
    TYPE state_type IS (INICIO, ESPERAR, SOMAR, CALCULAR, FORNECER);
    SIGNAL state, next_state : state_type;

BEGIN

    --Maquina de estados finitas de Moore
    --processo que realiza a passagem de estados ou retorno para o INICIO
    SYNC_PROCCESS : PROCESS (clk, rst)
    BEGIN
        --permanece em IDLE sempre que o rst for 1
        IF rst = '1' THEN

            state <= INICIO;

        ELSIF rising_edge(clk) THEN

            state <= next_state;

        END IF;
    END PROCESS SYNC_PROCCESS;

    --PROCESSO DE PASSAGEM DOS ESTADOS ATRAVES DAS CONDICOES
    fsm_next_state : PROCESS (state, c, tot_lt_s, tot_hg_s, tot_eq_s)
    BEGIN
        CASE state IS
            WHEN INICIO =>
                next_state <= ESPERAR;
            WHEN ESPERAR =>
                IF c = '1' THEN
                    next_state <= SOMAR;
                ELSIF c = '0' AND tot_lt_s = '0' AND tot_hg_s = '1' THEN
                    next_state <= CALCULAR;
                ELSIF c = '0' AND tot_lt_s = '0' AND tot_eq_s = '1' THEN
                    next_state <= FORNECER;
                ELSE
                    next_state <= ESPERAR;
                END IF;
            WHEN SOMAR =>
                next_state <= ESPERAR;
            WHEN CALCULAR =>
                next_state <= FORNECER;
            WHEN FORNECER =>
                next_state <= INICIO;

        END CASE;

    END PROCESS fsm_next_state;

    --Tratando as saídas nos estados
    d <= '1' WHEN state = FORNECER ELSE '0';
    tot_ld <= '1' WHEN state = SOMAR OR state = CALCULAR ELSE '0';
    tot_clr <= '1' WHEN state = INICIO ELSE '0';

END ARCHITECTURE arch;
