#pragma once


//Интерфес взаимодействия клиента (client_tcp) с внешним миром
class decoder
{
public:
    decoder();
    virtual void parse(char * arg_buf,int arg_size)
      {
      (void)arg_buf; (void)arg_size;
      };
    virtual void on_client_change_state(void *arg_state) {(void)arg_state;};
   // virtual void test_label(void){};
};


