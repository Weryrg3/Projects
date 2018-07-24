defmodule Learn.TestHelpers do
  @moduledoc false
  alias Learn.{
    NovosTestes,
    Relacionamentos,
    Repo,
    Thing
  }
  @button2 """
  111=default\n61=default\n58=default\n145=default\n118=default\n49=default\n
  10=default\n137=default\n92=default\n143=default\n37=default\n115=default\n
  78=default\n79=default\n116=default\n93=default\n113=default\n87=default\n
  24=default\n138=default\n96=default\n14=default\n148=default\n98=default\n
  75=default\n160=default\n71=default\n149=default\n12=default\n42=default\n
  36=default\n16=default\n4=primary\n106=default\n81=default\n26=default\n
  151=default\n165=default\n107=default\n105=default\n64=default\n34=default\n
  77=default\n32=default\n82=default\n46=default\n139=default\n155=default\n
  8=default\n5=default\n121=default\n3=default\n19=default\n102=default\n
  90=default\n9=default\n103=default\n129=default\n162=default\n7=default\n
  154=default\n50=default\n55=default\n13=default\n94=default\n44=default\n
  73=default\n120=default\n52=default\n74=default\n68=default\n89=default\n
  57=default\n2=default\n163=default\n157=default\n45=default\n142=default\n
  11=default\n40=default\n15=default\n29=default\n17=default\n85=default\n
  100=default\n63=default\n25=default\n126=default\n39=default\n65=default\n
  28=default\n54=default\n144=default\n166=default\n59=default\n67=default\n
  80=default\n122=default\n18=default\n27=default\n109=default\n35=default\n
  135=default\n156=default\n130=default\n83=default\n69=default\n110=default
  23=default\n159=default\n136=default\n99=default\n88=default\n125=default\n
  84=default\n147=default\n132=default\n152=default\n97=default\n131=default\n
  72=default\n114=default\n133=default\ncor=random\n31=default\n43=default\n
  128=default\n6=default\n41=default\n169=default\n76=default\n161=default\n
  30=default\n150=default\n153=default\n66=default\n104=default\n20=default\n
  22=default\n21=default\n141=default\n62=default\n117=default\n146=default\n
  56=default\n48=default\n140=default\n108=default\n95=default\n124=default\n
  134=default\n101=default\n38=default\n127=default\n168=default\n91=default\n
  167=default\n51=default\n47=default\n1=default\n123=default\n60=default\n
  33=default\n158=default\n164=default\n112=default\n119=default\n53=default\n
  70=default\n86=default
  """
  def thing(params \\ %{}) do
    Map.merge(
      %{
        name: "name teste",
        name2: "name2 teste",
        name3: "name3 teste"
      },
      params
    )
  end

  def relacionamento(params \\ %{}) do
    Map.merge(
      %{
        nome: "nome teste",
        campo: "13x13"
      },
      params
    )
  end

  def novos_testes(params \\ %{}) do
    Map.merge(
      %{
        texto: "texto teste",
        num: 1,
        buttons2: @button2
      },
      params
    )
  end

  def insert_thing(params \\ %{}) do
    changeset =
      Map.merge(
        %{
          name: "name teste",
          name2: "name2 teste",
          name3: "name3 teste"
        },
        params
      )

    insert_bd(Thing, changeset)
  end

  def insert_relacionamentos(params \\ %{}) do
    changeset =
      Map.merge(
        %{
          nome: "nome teste",
          campo: "campo teste"
        },
        params
      )

    insert_bd(Relacionamentos, changeset)
  end

  def insert_novos_testes(params \\ %{}) do
    changeset =
      Map.merge(
        %{
          texto: "texto teste",
          num: 1,
          buttons2: @button2
        },
        params
      )

    insert_bd(NovosTestes, changeset)
  end

  defp insert_bd(schema, params) do
    schema
    |> struct!()
    |> schema.changeset(params)
    |> Repo.insert!()
  end

  def get_bd(schema, id) do
    Repo.get(schema, id)
  end

  def get_bd_by(schema, arg) do
    Repo.get_by(schema, arg)
  end

  def bd_is_empty?(schema) do
    Enum.empty?(Repo.all(schema))
  end

  def preload_in_bd(struct, atom) do
    Repo.preload(struct, atom)
  end
end
