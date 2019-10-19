create procedure obtenerDatosDeProduccion
@fechaInicio as date = null,
@fechaFinal as date = null,
@idGranja as int = null,
@nombreGranja as varchar(50) = null,
@raza as varchar(50) = null,
@mensajeError as varchar(50) = null out
as begin
	if @fechaInicio is null and @fechaFinal is null and @idGranja is null and @nombreGranja is null
			and @raza is null begin
		set @mensajeError = 'Debe ingresar al menos un parametro';
		raiserror(@mensajeError, 1, 1);
		return;
	end else if @fechaInicio is null and @fechaFinal is null begin
		set @mensajeError = 'Debe ingresar las dos fechas';
		raiserror(@mensajeError, 1, 2);
		return;
	end else if @fechaFinal < @fechaInicio begin
		set @mensajeError = 'La fecha final debe ser mayor a la inicial';
		raiserror(@mensajeError, 1, 3);
		return;
	end else if @idGranja is not null and @idGranja < 0 begin
		set @mensajeError = 'El id debe ser positivo';
		raiserror(@mensajeError, 1, 4);
		return;
	end else if @nombreGranja = '' begin
		set @mensajeError = 'El nombre de la granja no puede estar vacio';
		raiserror(@mensajeError, 1, 5);
		return;
	end else if @raza = '' begin
		set @mensajeError = 'La raza no puede estar vacio';
		raiserror(@mensajeError, 1, 5);
		return;
	end
	declare @idRaza as smallint = null;
	if not exists (select idGranja = @idGranja from Granja where 
			(@idGranja is null or idGranja = @idGranja) and 
			(@nombreGranja is null or nombre = @nombreGranja)) begin
		set @mensajeError = 'La granja dada no existe';
		raiserror(@mensajeError, 2, 1);
		return;
	end else if not exists (select idRaza = @idRaza from Raza where 
			(@raza is null or nombre = @raza)) begin
		set @mensajeError = 'La raza dada no existe';
		raiserror(@mensajeError, 2, 1);
		return;
	end
	select Granja.nombre, Raza.nombre, COUNT(Huevo.idHuevo), TipoHuevo.idTipo from Huevo
	inner join Granja on Granja.idGranja = Huevo.idGranja
	inner join Gallina on Gallina.idGallina = Huevo.idGallina
	inner join Raza on Raza.idRaza = Gallina.idRaza
	inner join TipoHuevo on TipoHuevo.idTipo = Huevo.idTipo
	where (@fechaFinal is null or @fechaInicio < Huevo.fecha and Huevo.fecha < @fechaFinal) and 
	(@idGranja is null or Huevo.idGranja = @idGranja) and 
	(@idRaza is null or Gallina.idRaza = @idRaza) order by Raza.nombre
end

create procedure reportarHuevos
@idTipo as tinyint = null,
@tipo as varchar(50) = null,
@idGranja as tinyint = null,
@nombreGranja as varchar(50) = null,
@idRaza as smallint = null,
@nombreRaza as varchar(50) = null,
@idCanton as tinyint = null,
@nombreCanton as varchar(50) = null,
@mensajeError as varchar(50) = null out
as begin
	if @idTipo is null and @tipo is null and @idGranja is null and @nombreGranja is null
			and @idRaza is null and @nombreRaza is null and @idCanton is null
			and @nombreCanton is null begin
		set @mensajeError = 'Debe ingresar al menos un parametro';
		raiserror(@mensajeError, 1, 1);
		return;
	end else if @idTipo is not null and @idTipo < 0 begin
		set @mensajeError = 'El id debe ser positivo';
		raiserror(@mensajeError, 1, 4);
		return;
	end else if @tipo = '' begin
		set @mensajeError = 'El tipo de huevo no puede estar vacio';
		raiserror(@mensajeError, 1, 5);
		return;
	end else if @idGranja is not null and @idGranja < 0 begin
		set @mensajeError = 'El id debe ser positivo';
		raiserror(@mensajeError, 1, 4);
		return;
	end else if @nombreGranja = '' begin
		set @mensajeError = 'El nombre de la granja no puede estar vacio';
		raiserror(@mensajeError, 1, 5);
		return;
	end else if @idRaza is not null and @idRaza < 0 begin
		set @mensajeError = 'El id debe ser positivo';
		raiserror(@mensajeError, 1, 4);
		return;
	end else if @nombreRaza = '' begin
		set @mensajeError = 'La raza no puede estar vacia';
		raiserror(@mensajeError, 1, 5);
		return;
	end else if @idCanton is not null and @idCanton < 0 begin
		set @mensajeError = 'El id debe ser positivo';
		raiserror(@mensajeError, 1, 4);
		return;
	end else if @nombreCanton = '' begin
		set @mensajeError = 'El canton no puede estar vacio';
		raiserror(@mensajeError, 1, 5);
		return;
	end
	if not exists (select idTipo = @idTipo from TipoHuevo where 
			(@idTipo is null or idTipo = @idTipo) and (@tipo is null or tipo = @tipo)) begin
		set @mensajeError = 'El tipo dado no existe';
		raiserror(@mensajeError, 2, 1);
		return;
	end else if not exists (select idGranja = @idGranja from Granja where 
			(@idGranja is null or idGranja = @idGranja) and 
			(@nombreGranja is null or nombre = @nombreGranja)) begin
		set @mensajeError = 'La granja dada no existe';
		raiserror(@mensajeError, 2, 1);
		return;
	end else if not exists (select idRaza = @idRaza from Raza where 
			(@idRaza is null or idRaza = @idRaza) and 
			(@nombreRaza is null or nombre = @nopmbreRaza)) begin
		set @mensajeError = 'La raza dada no existe';
		raiserror(@mensajeError, 2, 1);
		return;
	end else if not exists (select idCanton = @idCanton from Canton where 
			(@idCanton is null or idCanton = @idCanton) and 
			(@nombreCanton is null or nombre = @nombreCanton)) begin
		set @mensajeError = 'El canton dado no existe';
		raiserror(@mensajeError, 2, 1);
		return;
	end
	select AVG(Huevo.idHuevo), COUNT(Huevo.idHuevo), AVG(Pedido.cantidad), COUNT(Pedido.cantidad), 
	COUNT(Huevo.idEstado) from Huevo
	inner join Estado on Estado.idEstado = Huevo.idEstado
	inner join Gallina on Gallina.idGallina = Huevo.idGallina
	inner join TipoXPedido on TipoXPedido.idTipo = TipoHuevo.idTipo
	inner join Pedido on Pedido.idPedido = TipoXPedido.idPedido
	inner join Cliente on Cliente.idCliente = Pedido.idCliente
	inner join Provincia on Provincia.idProvincia = Cliente.idProvincia
	inner join Canton on Canton.Provincia = Provincia.idProvincia
	where Estado.estado = 'Desechado' and (@idTipo is null or Huevo.idTipo = @idTipo) and 
	(@idGranja is null or Gallina.idGranja = @idGranja) and 
	(@idRaza is null or Gallina.idRaza = @idRaza) and 
	(@idCanton is null or Canton.idCanton = @idCanton)
end

create procedure pedido
@idTipos as varchar(20) = null,
@tipos as varchar(255) = null,
@cantidades as varchar(20),
@idCliente as int = null,
@nombreCliente as varchar(50) = null,
@mensajeError as varchar(50) = null,
@idPedido as int = null out,
@idFactura as int = null out
as begin
	if @idTipos is null and @tipos is null begin
		set @mensajeError = 'Debe ingresar los id o los nombres de los tipos';
		raiserror(@mensajeError, 1, 2);
		return;
	end else if @idTipos = '' begin
		set @mensajeError = 'Los id de los tipos no puede estar vacios';
		raiserror(@mensajeError, 1, 5);
		return;
	end else if @tipos = '' begin
		set @mensajeError = 'Los tipos no puede estar vacios';
		raiserror(@mensajeError, 1, 5);
		return;
	end else if @cantidades is null begin
		set @mensajeError = 'Debe ingresar las cantidades';
		raiserror(@mensajeError, 1, 6);
		return;
	end else if @cantidades = '' begin
		set @mensajeError = 'Las cantidades no puede estar vacias';
		raiserror(@mensajeError, 1, 5);
		return;
	end else if @idCliente is null and @nombreCliente is null begin
		set @mensajeError = 'Debe ingresar los id o el nombre del cleinte';
		raiserror(@mensajeError, 1, 2);
		return;
	end else if @idCliente is not null and @idCliente > 0 begin
		set @mensajeError = 'El id del cliente no puede ser negativo';
		raiserror(@mensajeError, 1, 4);
		return;
	end else if @nombreCliente = '' begin
		set @mensajeError = 'El nombre del cliente no puede estar vacio';
		raiserror(@mensajeError, 1, 5);
		return;
	end
	declare @idTiposFinales as varchar(20) = '';
	declare @precios as varchar(20) = '';
	if not exists(select CONCAT(@idTiposFinales, CAST(idTipo as varchar(3)), ',') from TipoHuevo 
			where (@idTipos is null or idTipo = CAST(STRING_SPLIT(@idTipos, ',') as tinyint)) and 
			(@tipos is null or tipo = STRING_SPLIT(@tipos, ','))) begin
		set @mensajeError = 'Los tipos dados no existen';
		raiserror(@mensajeError, 2, 1);
		return;
	end else if not exists(select CONCAT(@precios, CAST(TipoHuevo.precio as varchar(3)), ',') from Huevo 
			inner join TipoHuevo on TipoHuevo.idTipo = Huevo.idTipo where 
			Huevo.idTipo = CAST(STRING_SPLIT(@idTiposFinales, ',') as tinyint) having 
			COUNT(Huevo.idTipo) <= CAST(STRING_SPLIT(@cantidades, ',') as int)) begin
		set @mensajeError = 'No hay suficientes huevos';
		raiserror(@mensajeError, 2, 2);
		return;
	end else if not exists(select idCliente = @idCliente from Cliente where 
			(@idCliente is null or idCliente = @idCliente) and 
			(@nombreCliente is null or nombre = @nombreCliente)) begin
		set @mensajeError = 'El cliente no existe';
		raiserror(@mensajeError, 2, 1);
		return;
	end
	declare @monto as money = 0;
	begin transaction
	insert into Pedido(cantidad, idCliente) values 
	(CAST(STRING_SPLIT(@cantidades, ',') as int), @idCliente)
	select @idPedido = @@IDENTITY
	insert into TipoXPedido (idTipo, idPedido) values 
	(CAST(STRING_SPLIT(@idTiposFinales, ',') as tinyint), @idPedido)
	select @monto = SUM(STRING_SPLIT(@precios, ','))
	insert into Factura(monto, idPedido) values (@monto, @idPedido)
	select @idFactura = @@IDENTITY
	commit transaction
end