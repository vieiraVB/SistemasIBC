--
-- Estrutura para tabela `solicitacoes`
--

CREATE TABLE `solicitacoes` (
  `id` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `data_utilizacao` date NOT NULL,
  `horario_inicio` time NOT NULL,
  `horario_fim` time NOT NULL,
  `sala` varchar(100) DEFAULT NULL,
  `turno` enum('matutino','vespertino','noturno') DEFAULT NULL,
  `status` enum('pendente','aprovada','retirada','devolvida','cancelada') DEFAULT 'pendente',
  `observacoes` text DEFAULT NULL,
  `data_solicitacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_retirada` timestamp NULL DEFAULT NULL,
  `data_devolucao` timestamp NULL DEFAULT NULL,
  `aprovada_por` int(11) DEFAULT NULL,
  `tipo_solicitacao` enum('equipamentos','materiais','ambos') DEFAULT NULL,
  `materiais_solicitados` text DEFAULT NULL,
  `materiais_extras` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`materiais_extras`)),
  `data_necessaria_materiais` date DEFAULT NULL,
  `equipamentos_selecionados` text DEFAULT NULL COMMENT 'JSON com os equipamentos selecionados (datashow, notebook, ambos)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE TABLE `solicitacoes_materiais` (
  `id` int(11) NOT NULL,
  `id_material` int(11) NOT NULL,
  `usuario_id` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `data_solicitacao` timestamp NOT NULL DEFAULT current_timestamp(),
  `data_agendada` date NOT NULL,
  `status` enum('pendente','aprovada','rejeitada','concluida') DEFAULT 'pendente',
  `solicitacao_datashow_id` int(11) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `quantidade_solicitada` int(11) NOT NULL DEFAULT 1,
  `id_solicitacao` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices de tabela `solicitacoes`
--
ALTER TABLE `solicitacoes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `usuario_id` (`usuario_id`),
  ADD KEY `solicitacoes_ibfk_3` (`aprovada_por`),
  ADD KEY `idx_data_turno` (`data_utilizacao`,`turno`);

--
-- Índices de tabela `solicitacoes_materiais`
--
ALTER TABLE `solicitacoes_materiais`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_material` (`id_material`),
  ADD KEY `usuario_id` (`usuario_id`);


