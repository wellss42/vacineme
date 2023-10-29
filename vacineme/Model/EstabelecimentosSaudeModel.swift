//
//  EstabelecimentosSaude.swift
//  vacineme
//
//  Created by wellington martins on 12/10/23.
//

import Foundation

// MARK: - EstabelecimentosSaude
struct EstabelecimentosSaude: Codable {
    let estabelecimentos: [Estabelecimento]
}

// MARK: - Estabelecimento
struct Estabelecimento: Codable {
    let codigoCnes: Int
    let numeroCnpjEntidade: String?
    let nomeRazaoSocial, nomeFantasia: String
    let naturezaOrganizacaoEntidade: JSONNull?
    let tipoGestao: String
    let descricaoNivelHierarquia, descricaoEsferaAdministrativa: JSONNull?
    let codigoTipoUnidade: Int
    let codigoCepEstabelecimento, enderecoEstabelecimento, numeroEstabelecimento, bairroEstabelecimento: String
    let numeroTelefoneEstabelecimento: String?
    let latitudeEstabelecimentoDecimoGrau, longitudeEstabelecimentoDecimoGrau: Double?
    let enderecoEmailEstabelecimento, numeroCnpj: String?
    let codigoIdentificadorTurnoAtendimento, descricaoTurnoAtendimento, estabelecimentoFazAtendimentoAmbulatorialSUS, codigoEstabelecimentoSaude: String
    let codigoUf, codigoMunicipio: Int
    let descricaoNaturezaJuridicaEstabelecimento: String
//    let codigoMotivoDesabilitacaoEstabelecimento: Int?
    let estabelecimentoPossuiCentroCirurgico, estabelecimentoPossuiCentroObstetrico, estabelecimentoPossuiCentroNeonatal, estabelecimentoPossuiAtendimentoHospitalar: Int?
    let estabelecimentoPossuiServicoApoio, estabelecimentoPossuiAtendimentoAmbulatorial: Int
    let codigoAtividadeEnsinoUnidade: String
    let codigoNaturezaOrganizacaoUnidade, codigoNivelHierarquiaUnidade, codigoEsferaAdministrativaUnidade: JSONNull?

    enum CodingKeys: String, CodingKey {
        case codigoCnes = "codigo_cnes"
        case numeroCnpjEntidade = "numero_cnpj_entidade"
        case nomeRazaoSocial = "nome_razao_social"
        case nomeFantasia = "nome_fantasia"
        case naturezaOrganizacaoEntidade = "natureza_organizacao_entidade"
        case tipoGestao = "tipo_gestao"
        case descricaoNivelHierarquia = "descricao_nivel_hierarquia"
        case descricaoEsferaAdministrativa = "descricao_esfera_administrativa"
        case codigoTipoUnidade = "codigo_tipo_unidade"
        case codigoCepEstabelecimento = "codigo_cep_estabelecimento"
        case enderecoEstabelecimento = "endereco_estabelecimento"
        case numeroEstabelecimento = "numero_estabelecimento"
        case bairroEstabelecimento = "bairro_estabelecimento"
        case numeroTelefoneEstabelecimento = "numero_telefone_estabelecimento"
        case latitudeEstabelecimentoDecimoGrau = "latitude_estabelecimento_decimo_grau"
        case longitudeEstabelecimentoDecimoGrau = "longitude_estabelecimento_decimo_grau"
        case enderecoEmailEstabelecimento = "endereco_email_estabelecimento"
        case numeroCnpj = "numero_cnpj"
        case codigoIdentificadorTurnoAtendimento = "codigo_identificador_turno_atendimento"
        case descricaoTurnoAtendimento = "descricao_turno_atendimento"
        case estabelecimentoFazAtendimentoAmbulatorialSUS = "estabelecimento_faz_atendimento_ambulatorial_sus"
        case codigoEstabelecimentoSaude = "codigo_estabelecimento_saude"
        case codigoUf = "codigo_uf"
        case codigoMunicipio = "codigo_municipio"
        case descricaoNaturezaJuridicaEstabelecimento = "descricao_natureza_juridica_estabelecimento"
//        case codigoMotivoDesabilitacaoEstabelecimento = "codigo_motivo_desabilitacao_estabelecimento"
        case estabelecimentoPossuiCentroCirurgico = "estabelecimento_possui_centro_cirurgico"
        case estabelecimentoPossuiCentroObstetrico = "estabelecimento_possui_centro_obstetrico"
        case estabelecimentoPossuiCentroNeonatal = "estabelecimento_possui_centro_neonatal"
        case estabelecimentoPossuiAtendimentoHospitalar = "estabelecimento_possui_atendimento_hospitalar"
        case estabelecimentoPossuiServicoApoio = "estabelecimento_possui_servico_apoio"
        case estabelecimentoPossuiAtendimentoAmbulatorial = "estabelecimento_possui_atendimento_ambulatorial"
        case codigoAtividadeEnsinoUnidade = "codigo_atividade_ensino_unidade"
        case codigoNaturezaOrganizacaoUnidade = "codigo_natureza_organizacao_unidade"
        case codigoNivelHierarquiaUnidade = "codigo_nivel_hierarquia_unidade"
        case codigoEsferaAdministrativaUnidade = "codigo_esfera_administrativa_unidade"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
