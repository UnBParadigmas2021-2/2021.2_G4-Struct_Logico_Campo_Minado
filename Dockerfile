FROM swipl
 
WORKDIR /minesweeper
 
COPY . .

CMD ["swipl", "-s", "webserver.pl"]
