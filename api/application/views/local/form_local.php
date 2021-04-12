
                <div  class="col-sm-3">
                    <label for="estado">Estado</label>

                  <select name="estado" id="estado" tipo="estados" url="<?=site_url('local/listarCombo') ?>/" required>
                    <?php  
                     foreach ($estado as $dados ) {
                         echo $dados;
                     } 
                      ?>
                                        
                    </select>
                </div> 
                <div class="col-sm-3">
                    <label  for="cidade">Cidade</label>
                    <select  type="text" name="cidade" id="cidade" required>
                    </select>
                </div>
                <div class="col-sm-3">
                    <label  for="cep">CEP</label>
                    <?php
                    $atributos = array('name' => 'cep', 'id' => 'cep','value' => '', 'placeholder' => 'Apenas numeros');
                    echo form_input($atributos);
                    ?>
                </div>
                <div class="col-sm-3">
                    <label  for="bairro">Bairro </label>

                    <?php
                    $atributos = array('name' => 'bairro', 'id' => 'bairro','value' => '', 'placeholder' => 'Apenas numeros');
                    echo form_input($atributos);
                    ?>
                   
                </div>


                <div class="col-sm-12">
                    <label  for="complemento">Complemento</label>
                    <textarea  name="complemento" id="complemento" /></textarea>
                </div>
           