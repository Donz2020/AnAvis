package progetto.anavis.model;

import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import com.fasterxml.jackson.annotation.JsonProperty;

/**
 * Questa classe definisce l'oggetto prenotazione che viene emesso dalle sedi
 * avis, nella data e nell'orario che hanno a disposizione, per far effettuare
 * una donazione e che pu� essere prenotato da un solo donatore.
 * 
 * @author Lucia e Luca
 *
 */

@Entity
public class Prenotazione {

	@Id
	private UUID id;
	@NotBlank
	private String data, orario;
	private UUID idDonatore, idSede, idQuestionario;
	private TipoDonazione tipoDonazione;
	@NotNull
	private boolean disponibilita = false;

	public Prenotazione() {

	}

	public Prenotazione(@JsonProperty("idPrenotazione") UUID id, @JsonProperty("data") String data,
			@JsonProperty("orario") String orario, @JsonProperty(value = "idDonatore") UUID idD,
			@JsonProperty(value = "idSede") UUID idS,
			@JsonProperty(value = "tipoDonazione", defaultValue = "SANGUE_INTERO") TipoDonazione tipoDonazione,
			@JsonProperty(value = "disponibilita", defaultValue = "false") boolean disponibilita,
			@JsonProperty(value = "idQuestionario") UUID idQ) {
		this.id = id;
		this.data = data;
		this.orario = orario;
		this.idDonatore = idD != null ? idD : UUID.fromString("00000000-0000-0000-0000-000000000000");
		this.idSede = idS != null ? idS : UUID.fromString("00000000-0000-0000-0000-000000000000");
		this.tipoDonazione = tipoDonazione;
		this.disponibilita = disponibilita;
		this.idQuestionario = idQ != null ? idQ : UUID.fromString("00000000-0000-0000-0000-000000000000");
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getOrario() {
		return orario;
	}

	public void setOrario(String orario) {
		this.orario = orario;
	}

	public UUID getIdDonatore() {
		return idDonatore;
	}

	public void setIdDonatore(UUID idD) {
		this.idDonatore = idD;
	}

	public UUID getIdSede() {
		return idSede;
	}

	public void setIdSede(UUID idS) {
		this.idSede = idS;
	}

	public TipoDonazione getTipoDonazione() {
		return tipoDonazione;
	}

	public void setTipoDonazione(TipoDonazione tipoDonazione) {
		this.tipoDonazione = tipoDonazione;
	}

	public boolean getDisponibilita() {
		return disponibilita;
	}

	public void setDisponibilita(boolean disponibilita) {
		this.disponibilita = disponibilita;
	}

	public UUID getIdQuestionario() {
		return idQuestionario;
	}

	public void setIdQuestionario(UUID idQuestionario) {
		this.idQuestionario = idQuestionario;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null || getClass() != obj.getClass())
			return false;
		Prenotazione prenotazione = (Prenotazione) obj;
		return this.id.equals(prenotazione.id);
	}

	@Override
	public String toString() {
		return "\n" + "Data: " + this.data + ", Orario: " + this.orario + ", id Sede: " + this.idSede
				+ ", Disponibilit�: " + this.disponibilita;
	}

}