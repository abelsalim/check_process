#!/usr/bin/env python3.9

import subprocess
from asyncio import run, sleep, gather, to_thread
from psutil import process_iter
from constant import COMUNICADOR, MONITOR


def up_down(process):
    """
    Função responsável por identificar se o processo em palta está em execução.
    """
    for key, value in process.items():
        for processo in process_iter(['name']):
            if processo.info['name'] == key:
                return True
        subprocess.run(value, shell=True)


async def main():
    """
    Função principal que executa as verificações/execuções como concorrências.
    """
    while True:
        await gather(
            to_thread(up_down, MONITOR),
            to_thread(up_down, COMUNICADOR)
            )
        await sleep(10)


if __name__ == '__main__':
    run(main())

