function [vetClasses] = anotacaoClasses2(~)
   
	vetClasses = [];
    
    %%%%%%%PARTE DO PROGRAMA QUE RECEBE OS ARQUIVOS NECESSARIOS PARA
    %%%%%%%ALTERAR:
    %Variavel da imagem:
    pathDir = 'C:/Users/doug1/Desktop/Pesquisa/IMG_13_Labeled2.png';
    %Variavel do arquivo txt
    filename = 'C:/Users/doug1/Desktop/Pesquisa/ceratocystis_test_90_10_rgb.txt';
    %Numero da imagem
    var=13;
    
    %Abre o arquivo da imagem e o carrega na memória
    img = imread(pathDir); % read image from path
   
    %Abre o arquivo txt e seleciona apenas as colunas de x,y
    delimiterIn = ',';
    dados = importdata(filename,delimiterIn);
    r=dados((dados(:,1:1)==var),2:2);
    c=dados((dados(:,1:1)==var),3:3);
    
    %Obtem a cor de cada x,y da imagem
    colors = impixel(img, c, r);
   
    %Seleciona apenas uma coluna das três geradas pelo 'impixel'
    colors = colors(:,1:1);
%     disp(unique(colors(colors~=0 & colors~=127 & colors~=255)));
    %Remove a ultima coluna do arquivo original
    dados = dados((dados(:,1:1)==var),1:53);
	for i = 1:size(colors,1)
        %255=2
        %0=0
        %resto=1
%         if (colors(i)==0)
%             dados(i,54:54) = 0;
%         elseif (colors(i)<=127)
%             dados(i,54:54) = 1;
%         else
%             dados(i,54:54) = 2;
%         end
       switch colors(i)
           case 0
                dados(i,54:54) = 0;
           case 255
               dados(i,54:54) = 2;
           otherwise
               dados(i,54:54) = 1;
       end
    end
    %Aqui é escolhido o lugar de saída do arquivo criado, assim como seu
    %nome
    fid = fopen('C:/Users/doug1/Desktop/Pesquisa/myFile.txt','wt');
    for ii = 1:size(dados,1)
        fprintf(fid,'%g,',dados(ii,1:3));
        fprintf(fid,'%.6f,',dados(ii,4:53));
        fprintf(fid,'%g',dados(ii,54:54));
        fprintf(fid,'\n');
    end
    fclose(fid);
    
    %Área de teste que adiciona pontos na imagem original para validar que 
    %as classificações correspondem às cores lidas pela imagem
    %estão corretas.
    %Cor preta da imagem original = 0 = Solo = Ponto marrom
    c = dados((dados(:,54:54)==0),3:3);
    r = dados((dados(:,54:54)==0),2:2);
    figure,imshow(img);
    hold on;
    plot(c,r,'Color','c','LineStyle','none','Marker','.','MarkerSize',5);
    %Cor cinza e variações da imagem original = Planta saudável = Ponto
    %verde
    c = dados((dados(:,54:54)==1),3:3);
    r = dados((dados(:,54:54)==1),2:2);
%     figure,imshow(img);
%     hold on;
    plot(c,r,'Color','g','LineStyle','none','Marker','^','MarkerSize',5);
    %Cor branca da imagem original = 255 = Planta doente = Ponto vermelho
    c = dados((dados(:,54:54)==2),3:3);
    r = dados((dados(:,54:54)==2),2:2);
%     figure,imshow(img);
%     hold on;
    plot(c,r,'Color','r','LineStyle','none','Marker','+','MarkerSize',5);
end