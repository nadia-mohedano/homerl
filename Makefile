all:
erl -make

init:
-mkdir ebin
-chmod +x ./start.sh
cp src/homerl.app.src ebin/homerl.app
$(MAKE) all

clean:
rm -rf ./ebin/*.beam