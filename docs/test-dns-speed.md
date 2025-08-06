# test-dns-speed.ps1

Este script testa a velocidade de resolução DNS consultando uma lista de domínios de um arquivo CSV (`data/popular-domains.csv`), calcula o tempo médio de resolução por domínio e exibe uma mensagem indicando o desempenho (excelente, normal ou lento). Suporta sistemas Windows (usando `Resolve-DnsName`) e Linux (usando `dig`).

## Pré-requisitos
- **Sistema Operacional**: Windows 10 ou superior, ou distribuições Linux com PowerShell Core.
- **PowerShell**: Versão 5.1 ou superior (Windows) ou PowerShell Core (Linux).
- **Dependências**:
  - Um arquivo CSV (`data/popular-domains.csv`) com uma coluna `Domain` contendo nomes de domínios (ex.: `google.com`).
  - No Linux: O comando `dig` deve estar instalado (ex.: `sudo apt install dnsutils` no Ubuntu/Debian).
- **Permissões**: Não requer privilégios administrativos, exceto para `Clear-DnsClientCache` no Windows, que pode exigir privilégios elevados em algumas configurações.
- **Política de Execução**: Habilite a execução de scripts:
  ```powershell
  Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
  ```

## Uso
Execute o script no PowerShell:
```powershell
.\test-dns-speed.ps1
```

### Exemplo de Saída
- Desempenho excelente:
  ```
  ✅ Internet DNS: 8.5ms excellent lookup time
  ```
- Desempenho normal:
  ```
  ✅ Internet DNS: 45.2ms lookup time
  ```
- Desempenho lento:
  ```
  ⚠️ Internet DNS: 120.7ms slow lookup time
  ```
- Erro (arquivo CSV não encontrado):
  ```
  ⚠️ Error in line 10: CSV file not found at: C:\path\to\data\popular-domains.csv
  ```

## Formato do Arquivo CSV
O arquivo `data/popular-domains.csv` deve ter pelo menos uma coluna chamada `Domain`. Exemplo:
```csv
Domain
google.com
microsoft.com
amazon.com
```

## Notas
- O script limpa o cache DNS no Windows (`Clear-DnsClientCache`) para garantir resultados precisos.
- No Linux, requer o comando `dig` (parte do pacote `dnsutils`).
- O tempo médio de resolução é calculado dividindo o tempo total (em milissegundos) pelo número de domínios.
- Desempenho é classificado como:
  - Excelente: < 10 ms por domínio
  - Normal: 10–100 ms por domínio
  - Lento: > 100 ms por domínio