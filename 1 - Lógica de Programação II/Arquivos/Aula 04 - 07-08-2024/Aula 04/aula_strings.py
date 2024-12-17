def descrever(**kwargs):
    print(kwargs)
    for chave, valor in kwargs.items():
        print(f"chave: {chave}, valor: {valor}")

descrever(nome="Joey", idade="8", especie="cachorro")
