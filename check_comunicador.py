#!/usr/bin/python3

import threading as t
from subprocess import run, PIPE
from time import sleep 


def check_up():
    """
    Função simples para coletar e retornar o PID do programa Comunicador.
    """

    command = run(['ps -C Comunicador -o pid|grep -v PID'],
                  shell=True,
                  stdout=PIPE,
                  universal_newlines=True)

    return command.stdout.strip()


def up():
    """
    Função que executa o script que chama o Comunicador em background e
    redireciona sua saídas para /dev/null quando executada através de uma thread
    para limitar o consumo de memória.
    """

    com = ['/usr/bin/nohup /opt/sefaz/cco/bin/runcco-ser.sh > /dev/null 2>&1 &']

    t1 = t.Thread(target=run(com, shell=True), name='up')
    t1.start()
    t1.join()



if __name__ == '__main__':

    # O stdout do check_up(), ou seja, o output do run executado sempre será em
    # string, se o comunicador não estiver em execução o run() retornará um
    # string vazia, caso contrário o retorno será uma string com o PID do
    # processo.

    # Loop que verifica se o Comunicador está UP
    while True:
        if not check_up():
            up()

        sleep(10)

