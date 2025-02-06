
public class avion
{
    private float _altura;
    private float _velocidadAvion;
	private float _combustible;
    private int _o;
    
	public avion(float altura, float vel, float combustible, int o)
	{
		this._altura = altura;
		this._velocidadAvion = vel;
		this._combustible = combustible;
		this._o = o;
	}
	
	public float Altura
	{
		get 
		{
			return _altura;
		}
	}
	
	public int Orientacion
	{
		get
		{ 
			return _o;
		}
	}

    public float Combustible
    {
        get
        {
            return _combustible;
        }
    }

    public void Virar(int grados)
	{
		_o = (_o + grados) % 360;
		consumir_fuel(grados * 0.1);
	}

	//Metodos que sirve para ascender los metros indicados
	public void ascender(float metros)
	{
		_altura = _altura + metros;
		consumir_fuel(metros * 0.3);		
	}

	//Metodos que sirve para descender los metros indicados
	public void descender(float metros)
	{
		_altura = _altura - metros;
		if (_altura < 0)		
			_altura = 0;		
	}

	private void consumir_fuel(float litros)
	{
		_combustible = _combustible - litros;
		if (_combustible < 0)
			_combustible = 0;
	}
}
