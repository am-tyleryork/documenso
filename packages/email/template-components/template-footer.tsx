import { Section, Text } from '../components';
import { useBranding } from '../providers/branding';

export type TemplateFooterProps = {
  isDocument?: boolean;
};

export const TemplateFooter = ({ isDocument = true }: TemplateFooterProps) => {
  const branding = useBranding();

  return (
    <Section>
      <Text className="my-8 text-sm text-slate-400">
        AscensionModel™
        <br />
        Win More Customers
      </Text>
    </Section>
  );
};

export default TemplateFooter;
