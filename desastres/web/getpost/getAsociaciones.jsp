<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page isELIgnored = "false" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="json" uri="http://www.atg.com/taglibs/json" %>

<%@ include file="../jspf/database.jspf" %>

<c:choose>
	<c:when test="${param.tipo eq 'todasEmergencias'}">
		<sql:query var="emergencias" dataSource="${CatastrofesServer}">
			SELECT id, nombre
			FROM catastrofes
			WHERE marcador = (SELECT id FROM tipos_marcadores WHERE tipo_marcador = 'event')
			AND estado != (SELECT id FROM tipos_estados WHERE tipo_estado = 'erased')
		</sql:query>
	</c:when>
	<c:when test="${param.tipo eq 'emergencias'}">
		<sql:query var="emergencias" dataSource="${CatastrofesServer}">
			SELECT id, nombre
			FROM catastrofes
			WHERE marcador = (SELECT id FROM tipos_marcadores WHERE tipo_marcador = 'event')
			AND estado != (SELECT id FROM tipos_estados WHERE tipo_estado = 'erased')
			AND id NOT IN (SELECT DISTINCT id_emergencia
				FROM asociaciones_heridos_emergencias a
				WHERE id_herido = ?
				AND a.estado != (SELECT id FROM tipos_estados WHERE tipo_estado = 'erased'))
			<sql:param value="${param.iden}"/>
		</sql:query>
	</c:when>
	<c:when test="${param.tipo eq 'asociadas'}">
		<sql:query var="emergencias" dataSource="${CatastrofesServer}">
			SELECT c.id, c.nombre
			FROM catastrofes c, asociaciones_heridos_emergencias a
			WHERE c.id = a.id_emergencia
			AND a.id_herido = ?
			AND c.estado != (SELECT id FROM tipos_estados WHERE tipo_estado = 'erased')
			AND a.estado != (SELECT id FROM tipos_estados WHERE tipo_estado = 'erased')
			<sql:param value="${param.iden}"/>
		</sql:query>
	</c:when>
</c:choose>

<json:array>
	<c:forEach var="emergencia" items="${emergencias.rows}">
		<json:object>
			<json:property name="id" value="${emergencia.id}"/>
			<json:property name="nombre" value="${emergencia.nombre}"/>
		</json:object>
	</c:forEach>
</json:array>