self: super: {
  logseq = super.logseq.override {
    electron_27 = self.electron_24;
  };
}
